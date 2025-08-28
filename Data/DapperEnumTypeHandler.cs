using Dapper;
using System.Data;

namespace WanderlustApi.Data
{
    /// <summary>
    /// Dapper type handler for converting enums to strings and vice versa
    /// This ensures enums are stored as string values in the database
    /// </summary>
    /// <typeparam name="T">The enum type</typeparam>
    public class DapperEnumTypeHandler<T> : SqlMapper.TypeHandler<T> where T : struct, Enum
    {
        public override void SetValue(IDbDataParameter parameter, T value)
        {
            // Convert enum to string for database storage
            parameter.Value = value.ToString();
        }

        public override T Parse(object value)
        {
            // Convert string value from database back to enum
            if (value == null || value == DBNull.Value)
            {
                return default(T);
            }

            var stringValue = value.ToString();
            if (string.IsNullOrEmpty(stringValue))
            {
                return default(T);
            }

            // Parse the string value to enum
            if (Enum.TryParse<T>(stringValue, true, out var result))
            {
                return result;
            }

            // If parsing fails, return default value
            return default(T);
        }
    }
}
