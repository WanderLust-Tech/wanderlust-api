using System.ComponentModel.DataAnnotations;

namespace WanderlustApi.Models;

public enum ProgrammingLanguage
{
    Javascript,
    Typescript,
    Cpp,
    Python,
    Html,
    Css,
    Json,
    Gn
}

public enum DifficultyLevel
{
    Beginner,
    Intermediate,
    Advanced,
    Expert
}

public enum CodeExampleCategory
{
    GettingStarted,
    Architecture,
    Debugging,
    Performance,
    Security
}

public enum ExecutionEnvironment
{
    Browser,
    Node,
    Python,
    None
}

public class CodeExample
{
    public string Id { get; set; } = string.Empty;
    
    [Required]
    [MaxLength(200)]
    public string Title { get; set; } = string.Empty;
    
    [Required]
    [MaxLength(500)]
    public string Description { get; set; } = string.Empty;
    
    [MaxLength(2000)]
    public string? LongDescription { get; set; }
    
    [Required]
    public string Code { get; set; } = string.Empty;
    
    public ProgrammingLanguage Language { get; set; }
    public CodeExampleCategory Category { get; set; }
    public string? Subcategory { get; set; }
    public List<string> Tags { get; set; } = new();
    public DifficultyLevel Difficulty { get; set; }
    
    // Execution and interaction
    public bool Runnable { get; set; }
    public ExecutionEnvironment Environment { get; set; }
    public List<string> Dependencies { get; set; } = new();
    public string? SetupInstructions { get; set; }
    public string? ExpectedOutput { get; set; }
    
    // Learning and navigation
    public List<string> RelatedArticles { get; set; } = new();
    public List<string> RelatedExamples { get; set; } = new();
    public List<string> LearningObjectives { get; set; } = new();
    public List<string> Prerequisites { get; set; } = new();
    
    // Metadata
    public string Author { get; set; } = string.Empty;
    public DateTime DateCreated { get; set; }
    public DateTime DateModified { get; set; }
    public bool Verified { get; set; }
    public string? Source { get; set; }
    public string? License { get; set; }
    
    // Analytics and engagement
    public CodeExampleRatings Ratings { get; set; } = new();
    public CodeExampleUsageStats Usage { get; set; } = new();
    public List<string> Comments { get; set; } = new();
    public List<string> Bookmarks { get; set; } = new();
}

public class CodeExampleRatings
{
    public double Average { get; set; }
    public int Count { get; set; }
    public Dictionary<int, int> Distribution { get; set; } = new();
}

public class CodeExampleUsageStats
{
    public int Views { get; set; }
    public int Executions { get; set; }
    public int Downloads { get; set; }
    public int Shares { get; set; }
    public DateTime LastAccessed { get; set; }
    public double AverageExecutionTime { get; set; }
    public double SuccessRate { get; set; }
}
