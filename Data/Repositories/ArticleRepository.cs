using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;
using Dapper;
using WanderlustApi.Models;

namespace WanderlustApi.Data.Repositories
{
    public interface IArticleRepository
    {
        Task<IEnumerable<Article>> GetAllAsync();
        Task<IEnumerable<Article>> GetByTitleAsync(string title);
        Task<IEnumerable<Article>> GetByCategoryAsync(string category);
        Task<Article?> GetByIdAsync(int id);
        Task<Article?> GetByPathAsync(string path);
        Task<IEnumerable<string>> GetCategoriesAsync();
        Task<IEnumerable<Article>> GetFeaturedArticlesAsync();
        Task<IEnumerable<Article>> GetRecentArticlesAsync(int count = 10);
        Task<IEnumerable<Article>> SearchArticlesAsync(string searchTerm);
        Task<bool> IncrementViewCountAsync(int id);
    }

    public class ArticleRepository : IArticleRepository
    {
        private readonly IDbConnectionFactory _connectionFactory;
        private readonly ILogger<ArticleRepository> _logger;

        public ArticleRepository(IDbConnectionFactory connectionFactory, ILogger<ArticleRepository> logger)
        {
            _connectionFactory = connectionFactory;
            _logger = logger;
        }

        public async Task<IEnumerable<Article>> GetAllAsync()
        {
            try
            {
                using var connection = await _connectionFactory.CreateConnectionAsync();
                const string sql = @"SELECT * FROM Articles WHERE IsPublished = 1 ORDER BY CreatedAt DESC";
                var articles = await connection.QueryAsync<Article>(sql);
                return articles;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting all articles");
                throw;
            }
        }

        public async Task<IEnumerable<Article>> GetByTitleAsync(string title)
        {
            try
            {
                using var connection = await _connectionFactory.CreateConnectionAsync();
                const string sql = @"SELECT * FROM Articles WHERE Title LIKE @Title AND IsPublished = 1 ORDER BY CreatedAt DESC";
                var articles = await connection.QueryAsync<Article>(sql, new { Title = $"%{title}%" });
                return articles;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting articles by title");
                throw;
            }
        }

        public async Task<IEnumerable<Article>> GetByCategoryAsync(string category)
        {
            try
            {
                using var connection = await _connectionFactory.CreateConnectionAsync();
                const string sql = @"SELECT * FROM Articles WHERE Category = @Category AND IsPublished = 1 ORDER BY CreatedAt DESC";
                var articles = await connection.QueryAsync<Article>(sql, new { Category = category });
                return articles;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting articles by category");
                throw;
            }
        }

        public async Task<Article?> GetByIdAsync(int id)
        {
            try
            {
                using var connection = await _connectionFactory.CreateConnectionAsync();
                const string sql = @"SELECT * FROM Articles WHERE Id = @Id AND IsPublished = 1";
                var article = await connection.QueryFirstOrDefaultAsync<Article>(sql, new { Id = id });
                return article;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting article by ID {ArticleId}", id);
                throw;
            }
        }

        public async Task<Article?> GetByPathAsync(string path)
        {
            try
            {
                using var connection = await _connectionFactory.CreateConnectionAsync();
                const string sql = @"SELECT * FROM Articles WHERE Path = @Path AND IsPublished = 1";
                var article = await connection.QueryFirstOrDefaultAsync<Article>(sql, new { Path = path });
                return article;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting article by path {Path}", path);
                throw;
            }
        }

        public async Task<IEnumerable<string>> GetCategoriesAsync()
        {
            try
            {
                using var connection = await _connectionFactory.CreateConnectionAsync();
                const string sql = @"SELECT DISTINCT Category FROM Articles WHERE IsPublished = 1 AND Category IS NOT NULL ORDER BY Category";
                var categories = await connection.QueryAsync<string>(sql);
                return categories;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting article categories");
                throw;
            }
        }

        public async Task<IEnumerable<Article>> GetFeaturedArticlesAsync()
        {
            try
            {
                using var connection = await _connectionFactory.CreateConnectionAsync();
                const string sql = @"SELECT * FROM Articles WHERE IsPublished = 1 AND IsFeatured = 1 ORDER BY CreatedAt DESC";
                var articles = await connection.QueryAsync<Article>(sql);
                return articles;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting featured articles");
                throw;
            }
        }

        public async Task<IEnumerable<Article>> GetRecentArticlesAsync(int count = 10)
        {
            try
            {
                using var connection = await _connectionFactory.CreateConnectionAsync();
                const string sql = @"SELECT TOP(@Count) * FROM Articles WHERE IsPublished = 1 ORDER BY CreatedAt DESC";
                var articles = await connection.QueryAsync<Article>(sql, new { Count = count });
                return articles;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting recent articles");
                throw;
            }
        }

        public async Task<IEnumerable<Article>> SearchArticlesAsync(string searchTerm)
        {
            try
            {
                using var connection = await _connectionFactory.CreateConnectionAsync();
                const string sql = @"
                    SELECT * FROM Articles 
                    WHERE IsPublished = 1 
                    AND (Title LIKE @SearchTerm 
                         OR Content LIKE @SearchTerm 
                         OR Category LIKE @SearchTerm 
                         OR Tags LIKE @SearchTerm)
                    ORDER BY CreatedAt DESC";
                var articles = await connection.QueryAsync<Article>(sql, new { SearchTerm = $"%{searchTerm}%" });
                return articles;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error searching articles with term {SearchTerm}", searchTerm);
                throw;
            }
        }

        public async Task<bool> IncrementViewCountAsync(int id)
        {
            try
            {
                using var connection = await _connectionFactory.CreateConnectionAsync();
                const string sql = @"UPDATE Articles SET ViewCount = ViewCount + 1 WHERE Id = @Id";
                var rowsAffected = await connection.ExecuteAsync(sql, new { Id = id });
                return rowsAffected > 0;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error incrementing view count for article {ArticleId}", id);
                throw;
            }
        }
    }
}
