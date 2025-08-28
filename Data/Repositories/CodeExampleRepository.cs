using Dapper;
using System.Data;
using WanderlustApi.Models;

namespace WanderlustApi.Data.Repositories
{
    /// <summary>
    /// Repository interface for CodeExample operations
    /// </summary>
    public interface ICodeExampleRepository
    {
        Task<CodeExampleEntity?> GetByIdAsync(int id);
        Task<IEnumerable<CodeExampleEntity>> GetAllAsync();
        Task<IEnumerable<CodeExampleEntity>> GetByLanguageAsync(string language);
        Task<IEnumerable<CodeExampleEntity>> GetByDifficultyAsync(string difficulty);
        Task<IEnumerable<CodeExampleEntity>> GetByAuthorAsync(int authorId);
        Task<IEnumerable<CodeExampleEntity>> SearchAsync(string searchTerm);
        Task<CodeExampleEntity> CreateAsync(CodeExampleEntity codeExample);
        Task<CodeExampleEntity> UpdateAsync(CodeExampleEntity codeExample);
        Task<bool> DeleteAsync(int id);
        Task<bool> ExistsAsync(int id);
        Task<int> GetTotalCountAsync();
    }

    /// <summary>
    /// Dapper implementation of CodeExample repository
    /// </summary>
    public class CodeExampleRepository : ICodeExampleRepository
    {
        private readonly IDbConnectionFactory _connectionFactory;
        private readonly ILogger<CodeExampleRepository> _logger;

        public CodeExampleRepository(IDbConnectionFactory connectionFactory, ILogger<CodeExampleRepository> logger)
        {
            _connectionFactory = connectionFactory;
            _logger = logger;
        }

        public async Task<CodeExampleEntity?> GetByIdAsync(int id)
        {
            try
            {
                using var connection = await _connectionFactory.CreateConnectionAsync();
                
                const string sql = @"
                    SELECT ce.Id, ce.Title, ce.Description, ce.Code, ce.Language, ce.Framework,
                           ce.Tags, ce.Difficulty, ce.Category, ce.IsPublic, ce.ViewCount, 
                           ce.LikeCount, ce.CreatedAt, ce.UpdatedAt, ce.AuthorId, ce.CollectionId,
                           ce.Dependencies, ce.RelatedExamples,
                           u.Username as AuthorName
                    FROM CodeExamples ce
                    LEFT JOIN Users u ON ce.AuthorId = u.Id
                    WHERE ce.Id = @Id";

                return await connection.QueryFirstOrDefaultAsync<CodeExampleEntity>(sql, new { Id = id });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting code example by ID {CodeExampleId}", id);
                throw;
            }
        }

        public async Task<IEnumerable<CodeExampleEntity>> GetAllAsync()
        {
            try
            {
                using var connection = await _connectionFactory.CreateConnectionAsync();
                
                const string sql = @"
                    SELECT ce.Id, ce.Title, ce.Description, ce.Code, ce.Language, ce.Framework,
                           ce.Tags, ce.Difficulty, ce.Category, ce.IsPublic, ce.ViewCount, 
                           ce.LikeCount, ce.CreatedAt, ce.UpdatedAt, ce.AuthorId, ce.CollectionId,
                           ce.Dependencies, ce.RelatedExamples,
                           u.Username as AuthorName
                    FROM CodeExamples ce
                    LEFT JOIN Users u ON ce.AuthorId = u.Id
                    WHERE ce.IsPublic = 1
                    ORDER BY ce.CreatedAt DESC";

                return await connection.QueryAsync<CodeExampleEntity>(sql);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting all code examples");
                throw;
            }
        }

        public async Task<IEnumerable<CodeExampleEntity>> GetByLanguageAsync(string language)
        {
            try
            {
                using var connection = await _connectionFactory.CreateConnectionAsync();
                
                const string sql = @"
                    SELECT ce.Id, ce.Title, ce.Description, ce.Code, ce.Language, ce.Framework,
                           ce.Tags, ce.Difficulty, ce.Category, ce.IsPublic, ce.ViewCount, 
                           ce.LikeCount, ce.CreatedAt, ce.UpdatedAt, ce.AuthorId, ce.CollectionId,
                           ce.Dependencies, ce.RelatedExamples,
                           u.Username as AuthorName
                    FROM CodeExamples ce
                    LEFT JOIN Users u ON ce.AuthorId = u.Id
                    WHERE ce.Language = @Language AND ce.IsPublic = 1
                    ORDER BY ce.CreatedAt DESC";

                return await connection.QueryAsync<CodeExampleEntity>(sql, new { Language = language });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting code examples by language {Language}", language);
                throw;
            }
        }

        public async Task<IEnumerable<CodeExampleEntity>> GetByDifficultyAsync(string difficulty)
        {
            try
            {
                using var connection = await _connectionFactory.CreateConnectionAsync();
                
                const string sql = @"
                    SELECT ce.Id, ce.Title, ce.Description, ce.Code, ce.Language, ce.Framework,
                           ce.Tags, ce.Difficulty, ce.Category, ce.IsPublic, ce.ViewCount, 
                           ce.LikeCount, ce.CreatedAt, ce.UpdatedAt, ce.AuthorId, ce.CollectionId,
                           ce.Dependencies, ce.RelatedExamples,
                           u.Username as AuthorName
                    FROM CodeExamples ce
                    LEFT JOIN Users u ON ce.AuthorId = u.Id
                    WHERE ce.Difficulty = @Difficulty AND ce.IsPublic = 1
                    ORDER BY ce.CreatedAt DESC";

                return await connection.QueryAsync<CodeExampleEntity>(sql, new { Difficulty = difficulty });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting code examples by difficulty {Difficulty}", difficulty);
                throw;
            }
        }

        public async Task<IEnumerable<CodeExampleEntity>> GetByAuthorAsync(int authorId)
        {
            try
            {
                using var connection = await _connectionFactory.CreateConnectionAsync();
                
                const string sql = @"
                    SELECT ce.Id, ce.Title, ce.Description, ce.Code, ce.Language, ce.Framework,
                           ce.Tags, ce.Difficulty, ce.Category, ce.IsPublic, ce.ViewCount, 
                           ce.LikeCount, ce.CreatedAt, ce.UpdatedAt, ce.AuthorId, ce.CollectionId,
                           ce.Dependencies, ce.RelatedExamples,
                           u.Username as AuthorName
                    FROM CodeExamples ce
                    LEFT JOIN Users u ON ce.AuthorId = u.Id
                    WHERE ce.AuthorId = @AuthorId
                    ORDER BY ce.CreatedAt DESC";

                return await connection.QueryAsync<CodeExampleEntity>(sql, new { AuthorId = authorId });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting code examples by author {AuthorId}", authorId);
                throw;
            }
        }

        public async Task<IEnumerable<CodeExampleEntity>> SearchAsync(string searchTerm)
        {
            try
            {
                using var connection = await _connectionFactory.CreateConnectionAsync();
                
                const string sql = @"
                    SELECT ce.Id, ce.Title, ce.Description, ce.Code, ce.Language, ce.Framework,
                           ce.Tags, ce.Difficulty, ce.Category, ce.IsPublic, ce.ViewCount, 
                           ce.LikeCount, ce.CreatedAt, ce.UpdatedAt, ce.AuthorId, ce.CollectionId,
                           ce.Dependencies, ce.RelatedExamples,
                           u.Username as AuthorName
                    FROM CodeExamples ce
                    LEFT JOIN Users u ON ce.AuthorId = u.Id
                    WHERE ce.IsPublic = 1 
                      AND (ce.Title LIKE @SearchTerm 
                           OR ce.Description LIKE @SearchTerm 
                           OR ce.Tags LIKE @SearchTerm
                           OR ce.Language LIKE @SearchTerm)
                    ORDER BY ce.CreatedAt DESC";

                var searchPattern = $"%{searchTerm}%";
                return await connection.QueryAsync<CodeExampleEntity>(sql, new { SearchTerm = searchPattern });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error searching code examples with term {SearchTerm}", searchTerm);
                throw;
            }
        }

        public async Task<CodeExampleEntity> CreateAsync(CodeExampleEntity codeExample)
        {
            try
            {
                using var connection = await _connectionFactory.CreateConnectionAsync();
                
                const string sql = @"
                    INSERT INTO CodeExamples (Title, Description, Code, Language, Framework, Tags, 
                                            Difficulty, Category, IsPublic, ViewCount, LikeCount,
                                            CreatedAt, UpdatedAt, AuthorId, CollectionId, 
                                            Dependencies, RelatedExamples)
                    VALUES (@Title, @Description, @Code, @Language, @Framework, @Tags, 
                            @Difficulty, @Category, @IsPublic, @ViewCount, @LikeCount,
                            @CreatedAt, @UpdatedAt, @AuthorId, @CollectionId, 
                            @Dependencies, @RelatedExamples);
                    
                    SELECT CAST(SCOPE_IDENTITY() AS INT);";

                var id = await connection.QuerySingleAsync<int>(sql, codeExample);
                codeExample.Id = id;
                
                _logger.LogInformation("Created code example with ID {CodeExampleId}", id);
                return codeExample;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error creating code example {Title}", codeExample.Title);
                throw;
            }
        }

        public async Task<CodeExampleEntity> UpdateAsync(CodeExampleEntity codeExample)
        {
            try
            {
                using var connection = await _connectionFactory.CreateConnectionAsync();
                
                const string sql = @"
                    UPDATE CodeExamples 
                    SET Title = @Title, Description = @Description, Code = @Code, 
                        Language = @Language, Framework = @Framework, Tags = @Tags, 
                        Difficulty = @Difficulty, Category = @Category, IsPublic = @IsPublic,
                        ViewCount = @ViewCount, LikeCount = @LikeCount, UpdatedAt = @UpdatedAt, 
                        CollectionId = @CollectionId, Dependencies = @Dependencies, 
                        RelatedExamples = @RelatedExamples
                    WHERE Id = @Id";

                var rowsAffected = await connection.ExecuteAsync(sql, codeExample);
                
                if (rowsAffected == 0)
                {
                    throw new InvalidOperationException($"Code example with ID {codeExample.Id} not found");
                }
                
                _logger.LogInformation("Updated code example with ID {CodeExampleId}", codeExample.Id);
                return codeExample;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error updating code example {CodeExampleId}", codeExample.Id);
                throw;
            }
        }

        public async Task<bool> DeleteAsync(int id)
        {
            try
            {
                using var connection = await _connectionFactory.CreateConnectionAsync();
                
                const string sql = "DELETE FROM CodeExamples WHERE Id = @Id";
                
                var rowsAffected = await connection.ExecuteAsync(sql, new { Id = id });
                
                _logger.LogInformation("Deleted code example with ID {CodeExampleId}", id);
                return rowsAffected > 0;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error deleting code example {CodeExampleId}", id);
                throw;
            }
        }

        public async Task<bool> ExistsAsync(int id)
        {
            try
            {
                using var connection = await _connectionFactory.CreateConnectionAsync();
                
                const string sql = "SELECT COUNT(1) FROM CodeExamples WHERE Id = @Id";
                
                var count = await connection.QuerySingleAsync<int>(sql, new { Id = id });
                return count > 0;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error checking if code example exists {CodeExampleId}", id);
                throw;
            }
        }

        public async Task<int> GetTotalCountAsync()
        {
            try
            {
                using var connection = await _connectionFactory.CreateConnectionAsync();
                
                const string sql = "SELECT COUNT(1) FROM CodeExamples WHERE IsPublic = 1";
                
                return await connection.QuerySingleAsync<int>(sql);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting total code examples count");
                throw;
            }
        }
    }
}
