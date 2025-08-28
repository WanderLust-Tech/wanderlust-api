using WanderlustApi.Data.Repositories;
using WanderlustApi.Models;
using WanderlustApi.Data.Mock;

namespace WanderlustApi.Data.Mock
{
    public class MockCodeExampleRepository : ICodeExampleRepository
    {
        private readonly ILogger<MockCodeExampleRepository> _logger;

        public MockCodeExampleRepository(ILogger<MockCodeExampleRepository> logger)
        {
            _logger = logger;
            _logger.LogWarning("Using MOCK CodeExampleRepository - Database connection failed");
        }

        public async Task<CodeExampleEntity?> GetByIdAsync(int id)
        {
            await Task.Delay(10); // Simulate async operation
            return MockData.CodeExamples.FirstOrDefault(c => c.Id == id);
        }

        public async Task<IEnumerable<CodeExampleEntity>> GetAllAsync()
        {
            await Task.Delay(10);
            return MockData.CodeExamples
                .Where(c => c.IsPublic)
                .ToList();
        }

        public async Task<IEnumerable<CodeExampleEntity>> GetByLanguageAsync(string language)
        {
            await Task.Delay(10);
            return MockData.CodeExamples
                .Where(c => c.IsPublic && c.Language.Equals(language, StringComparison.OrdinalIgnoreCase))
                .ToList();
        }

        public async Task<IEnumerable<CodeExampleEntity>> GetByDifficultyAsync(string difficulty)
        {
            await Task.Delay(10);
            return MockData.CodeExamples
                .Where(c => c.IsPublic && c.Difficulty.Equals(difficulty, StringComparison.OrdinalIgnoreCase))
                .ToList();
        }

        public async Task<IEnumerable<CodeExampleEntity>> GetByAuthorAsync(int authorId)
        {
            await Task.Delay(10);
            return MockData.CodeExamples
                .Where(c => c.IsPublic && c.AuthorId == authorId)
                .ToList();
        }

        public async Task<IEnumerable<CodeExampleEntity>> SearchAsync(string searchTerm)
        {
            await Task.Delay(10);
            var term = searchTerm.ToLowerInvariant();
            return MockData.CodeExamples
                .Where(c => c.IsPublic && (
                    c.Title.ToLowerInvariant().Contains(term) ||
                    c.Description?.ToLowerInvariant().Contains(term) == true ||
                    c.Code.ToLowerInvariant().Contains(term) ||
                    c.Language.ToLowerInvariant().Contains(term) ||
                    c.Framework?.ToLowerInvariant().Contains(term) == true ||
                    c.Category?.ToLowerInvariant().Contains(term) == true
                ))
                .ToList();
        }

        public async Task<CodeExampleEntity> CreateAsync(CodeExampleEntity codeExample)
        {
            await Task.Delay(10);
            codeExample.Id = MockData.GetNextCodeExampleId();
            codeExample.CreatedAt = DateTime.UtcNow;
            codeExample.UpdatedAt = DateTime.UtcNow;
            MockData.CodeExamples.Add(codeExample);
            _logger.LogInformation("Created mock code example with ID {CodeExampleId}", codeExample.Id);
            return codeExample;
        }

        public async Task<CodeExampleEntity> UpdateAsync(CodeExampleEntity codeExample)
        {
            await Task.Delay(10);
            var existingExample = MockData.CodeExamples.FirstOrDefault(c => c.Id == codeExample.Id);
            if (existingExample != null)
            {
                var index = MockData.CodeExamples.IndexOf(existingExample);
                codeExample.UpdatedAt = DateTime.UtcNow;
                MockData.CodeExamples[index] = codeExample;
                _logger.LogInformation("Updated mock code example with ID {CodeExampleId}", codeExample.Id);
            }
            return codeExample;
        }

        public async Task<bool> DeleteAsync(int id)
        {
            await Task.Delay(10);
            var codeExample = MockData.CodeExamples.FirstOrDefault(c => c.Id == id);
            if (codeExample != null)
            {
                MockData.CodeExamples.Remove(codeExample);
                _logger.LogInformation("Deleted mock code example with ID {CodeExampleId}", id);
                return true;
            }
            return false;
        }

        public async Task<bool> ExistsAsync(int id)
        {
            await Task.Delay(10);
            return MockData.CodeExamples.Any(c => c.Id == id);
        }

        public async Task<int> GetTotalCountAsync()
        {
            await Task.Delay(10);
            return MockData.CodeExamples.Count(c => c.IsPublic);
        }
    }
}
