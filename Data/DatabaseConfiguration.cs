// Database configuration for Dapper-based data access
// This file contains schema definitions and helper classes for database operations

using System.Text.Json;

namespace WanderlustApi.Data
{
    /// <summary>
    /// Database schema information and configuration for Dapper
    /// </summary>
    public static class DatabaseSchema
    {
        // Table names as constants
        public const string USERS_TABLE = "Users";
        public const string ARTICLES_TABLE = "Articles";
        public const string COMMUNITY_POSTS_TABLE = "CommunityPosts";
        public const string CODE_EXAMPLES_TABLE = "CodeExamples";
        public const string COMMENTS_TABLE = "Comments";
        public const string REACTIONS_TABLE = "Reactions";
        public const string USER_BADGES_TABLE = "UserBadges";
        public const string USER_PREFERENCES_TABLE = "UserPreferences";
        public const string DISCUSSION_CATEGORIES_TABLE = "DiscussionCategories";
        public const string COLLECTIONS_TABLE = "Collections";

        // Common SQL snippets
        public static class SqlQueries
        {
            public const string USER_WITH_PREFERENCES = @"
                SELECT u.*, up.* FROM Users u
                LEFT JOIN UserPreferences up ON u.Id = up.UserId
                WHERE u.Id = @Id";

            public const string POST_WITH_AUTHOR = @"
                SELECT cp.*, u.Username, u.DisplayName, u.AvatarUrl 
                FROM CommunityPosts cp
                LEFT JOIN Users u ON cp.AuthorId = u.Id
                WHERE cp.Id = @Id";

            public const string COMMENTS_WITH_AUTHORS = @"
                SELECT c.*, u.Username, u.DisplayName, u.AvatarUrl 
                FROM Comments c
                LEFT JOIN Users u ON CAST(c.AuthorId AS INT) = u.Id
                WHERE c.PostId = @PostId AND c.IsDeleted = 0
                ORDER BY c.CreatedAt ASC";
        }
    }

    /// <summary>
    /// Helper methods for JSON serialization in Dapper
    /// </summary>
    public static class JsonHelper
    {
        private static readonly JsonSerializerOptions _options = new()
        {
            PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
            WriteIndented = false
        };

        public static string Serialize<T>(T obj)
        {
            return JsonSerializer.Serialize(obj, _options);
        }

        public static T? Deserialize<T>(string json)
        {
            if (string.IsNullOrEmpty(json))
                return default;

            return JsonSerializer.Deserialize<T>(json, _options);
        }

        public static List<T> DeserializeList<T>(string json)
        {
            if (string.IsNullOrEmpty(json))
                return new List<T>();

            return JsonSerializer.Deserialize<List<T>>(json, _options) ?? new List<T>();
        }
    }
}
