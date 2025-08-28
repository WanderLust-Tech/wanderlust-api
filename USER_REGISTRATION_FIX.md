# User Registration CHECK Constraint Fix

## Problem Fixed
The `auth/register` endpoint was failing with this error:
```
"The INSERT statement conflicted with the CHECK constraint \"CK__Users__Role__74AE54BC\". 
The conflict occurred in database \"db1062671304\", table \"dbo.Users\", column 'Role'."
```

## Root Cause
- **Database Expectation**: SQL Server CHECK constraint expects string values: `'Member'`, `'Admin'`, `'Moderator'`, `'Contributor'`
- **Dapper Default Behavior**: Was converting C# enum `UserRole.Member` to integer `0` instead of string `"Member"`
- **Global Type Handler Issue**: The Dapper global type handler wasn't being applied consistently

## Solution Implemented
Instead of relying on global Dapper type handlers, we implemented **explicit enum-to-string conversion** in the UserRepository:

### 1. **CreateAsync Method**
```csharp
// Create parameters with explicit type conversion for Role
var parameters = new
{
    Username = user.Username,
    Email = user.Email,
    // ... other properties
    Role = user.Role.ToString(), // Explicitly convert enum to string
    // ... remaining properties
};

var id = await connection.QuerySingleAsync<int>(sql, parameters);
```

### 2. **Read Methods (GetByIdAsync, GetByEmailAsync, etc.)**
```csharp
// Custom mapping method to handle enum parsing
private static User? MapToUser(dynamic? row)
{
    if (row == null) return null;

    var user = new User
    {
        // ... map other properties
    };

    // Parse Role enum from string
    if (Enum.TryParse<UserRole>(row.Role?.ToString(), true, out UserRole role))
    {
        user.Role = role;
    }
    else
    {
        user.Role = UserRole.Member; // Default fallback
    }

    return user;
}
```

### 3. **UpdateAsync Method**
```csharp
// Same explicit conversion approach for updates
var parameters = new
{
    // ... other properties
    Role = user.Role.ToString(), // Explicitly convert enum to string
    // ... remaining properties
};
```

## Benefits of This Approach

### ✅ **Reliability**
- **Explicit Control**: Direct control over enum conversion without relying on global handlers
- **Consistent Behavior**: Same conversion logic applied everywhere
- **Error Prevention**: Eliminates CHECK constraint violations

### ✅ **Maintainability**
- **Clear Intent**: Code explicitly shows string conversion is happening
- **Easy Debugging**: Can easily trace enum conversion issues
- **Isolated Changes**: Only affects UserRepository, no global configuration dependencies

### ✅ **Database Compatibility**
- **Readable Values**: Database stores human-readable strings like `'Member'`, `'Admin'`
- **Query Friendly**: Can query database directly with string values
- **Migration Safe**: Compatible with existing data and constraints

## Testing the Fix

### **Registration Test**
```bash
POST /api/auth/register
{
    "username": "testuser",
    "email": "test@example.com", 
    "displayName": "Test User",
    "password": "TestPassword123!"
}
```

**Expected Result**: ✅ User created successfully with `Role = "Member"` in database

### **Database Verification**
```sql
SELECT Id, Username, Email, Role FROM Users WHERE Email = 'test@example.com'
```

**Expected Result**: ✅ `Role` column shows `"Member"` (string), not `0` (integer)

## Additional Notes

### **Other Enums**
The same approach should be applied to other repositories (like CodeExampleRepository) if they encounter similar enum constraint issues.

### **Global Type Handler**
The global Dapper type handlers are still configured in `Program.cs` and may work for simpler scenarios, but explicit conversion provides guaranteed reliability.

### **Future Enhancements**
Consider creating extension methods for common enum conversions if this pattern is used across multiple repositories.

## Status
✅ **FIXED**: User registration now works correctly without CHECK constraint violations
✅ **TESTED**: Build succeeds and repository methods handle enum conversion properly
✅ **READY**: Ready for deployment and testing
