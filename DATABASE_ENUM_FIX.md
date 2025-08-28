# Database Enum Constraint Fix

## Problem
When using the `auth/register` endpoint, users were encountering this error:
```
"The INSERT statement conflicted with the CHECK constraint \"CK__Users__Role__74AE54BC\". 
The conflict occurred in database \"db1062671304\", table \"dbo.Users\", column 'Role'."
```

## Root Cause
The issue was caused by a mismatch between how Dapper handles C# enums and what the SQL Server database expects:

1. **C# Enum**: `UserRole.Member` (enum value)
2. **Dapper Default**: Converts enum to integer value `0`
3. **Database Constraint**: Expects string values `('Member', 'Admin', 'Moderator', 'Contributor')`

The database CHECK constraint was expecting string values like `'Member'`, but Dapper was sending integer values like `0`.

## Solution
Implemented a custom Dapper type handler (`DapperEnumTypeHandler<T>`) that:
- Converts C# enums to strings when saving to database
- Converts string values from database back to C# enums when reading
- Handles all enum types used in the project

### Affected Enums
1. **UserRole**: `Member`, `Contributor`, `Moderator`, `Admin`
2. **ProgrammingLanguage**: `Javascript`, `Typescript`, `Cpp`, `Python`, `Html`, `Css`, `Json`, `Gn`
3. **DifficultyLevel**: `Beginner`, `Intermediate`, `Advanced`, `Expert`
4. **CodeExampleCategory**: `GettingStarted`, `Architecture`, `Debugging`, `Performance`, `Security`
5. **ExecutionEnvironment**: `Browser`, `Node`, `Python`, `None`

## Implementation Details

### 1. DapperEnumTypeHandler.cs
```csharp
public class DapperEnumTypeHandler<T> : SqlMapper.TypeHandler<T> where T : struct, Enum
{
    public override void SetValue(IDbDataParameter parameter, T value)
    {
        parameter.Value = value.ToString(); // Convert to string
    }

    public override T Parse(object value)
    {
        // Convert string back to enum with error handling
        return Enum.TryParse<T>(value?.ToString(), true, out var result) ? result : default(T);
    }
}
```

### 2. Program.cs Configuration
```csharp
// Configure Dapper to handle enums as strings
SqlMapper.AddTypeHandler(new DapperEnumTypeHandler<UserRole>());
SqlMapper.AddTypeHandler(new DapperEnumTypeHandler<ProgrammingLanguage>());
SqlMapper.AddTypeHandler(new DapperEnumTypeHandler<DifficultyLevel>());
SqlMapper.AddTypeHandler(new DapperEnumTypeHandler<CodeExampleCategory>());
SqlMapper.AddTypeHandler(new DapperEnumTypeHandler<ExecutionEnvironment>());
```

## Database Schema Alignment

### Users Table
```sql
Role NVARCHAR(20) NOT NULL DEFAULT 'Member' 
CHECK (Role IN ('Member', 'Admin', 'Moderator', 'Contributor'))
```

### CodeExamples Table
```sql
Difficulty NVARCHAR(20) NOT NULL DEFAULT 'Beginner' 
CHECK (Difficulty IN ('Beginner', 'Intermediate', 'Advanced', 'Expert'))
```

## Testing the Fix

### 1. Registration Test
```bash
POST /api/auth/register
{
    "username": "testuser",
    "email": "test@example.com", 
    "displayName": "Test User",
    "password": "TestPassword123!"
}
```

**Expected Result**: User should be created successfully with `Role = "Member"`

### 2. Database Verification
```sql
SELECT Id, Username, Email, Role FROM Users WHERE Email = 'test@example.com'
```

**Expected Result**: `Role` column should contain string value `"Member"`, not integer `0`

### 3. Code Example Creation Test
```bash
POST /api/codeexamples
{
    "title": "Test Example",
    "code": "console.log('Hello');",
    "language": "Javascript",
    "difficulty": "Beginner"
}
```

**Expected Result**: Code example should be created with string values for enums

## Benefits
1. **Compatibility**: Ensures C# enums work correctly with SQL Server CHECK constraints
2. **Data Integrity**: String values in database are human-readable and maintainable
3. **Flexibility**: Same handler works for all enum types
4. **Error Prevention**: Prevents constraint violation errors during registration and data creation

## Migration Notes
- **Existing Data**: If you have existing integer enum values in the database, they need to be converted to strings
- **Backward Compatibility**: New string-based approach is not compatible with old integer values
- **Fresh Database**: This fix works correctly with fresh database deployments using the provided SQL schema

## Troubleshooting
If you still encounter enum-related errors:
1. Verify the database schema matches the provided SQL script
2. Check that all enum values in C# match the CHECK constraint values in SQL
3. Ensure the type handlers are registered before any database operations
4. Clear any cached connections or restart the application after applying the fix
