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
    }
}
