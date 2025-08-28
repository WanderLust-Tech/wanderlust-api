using WanderlustApi.Models;

namespace WanderlustApi.Data.Mock
{
    public static class MockData
    {
        public static List<User> Users { get; } = new List<User>
        {
            new User
            {
                Id = 1,
                Username = "admin",
                Email = "admin@wanderlust.dev",
                DisplayName = "System Administrator",
                PasswordHash = "$2a$11$8Mg6lK7PZXhOGdWfHf9JeOKZ7mFQEG9pGqr7A2LhO2kZeO2.9q8Wa", // admin123
                Role = UserRole.Admin,
                IsEmailVerified = true,
                IsActive = true,
                Bio = "System administrator account for Wanderlust API",
                CreatedAt = DateTime.UtcNow.AddDays(-30),
                LastLoginAt = DateTime.UtcNow.AddHours(-1)
            },
            new User
            {
                Id = 2,
                Username = "developer",
                Email = "user@wanderlust.dev",
                DisplayName = "Sample Developer",
                PasswordHash = "$2a$11$LtKtQ9vL4bJ7XzWF8Q2YUO7K3mP9nT5xB1sN6eRzV2qH4yY8jT7Ca", // user123
                Role = UserRole.Member,
                IsEmailVerified = true,
                IsActive = true,
                Bio = "Sample developer account for testing",
                CreatedAt = DateTime.UtcNow.AddDays(-15),
                LastLoginAt = DateTime.UtcNow.AddMinutes(-30)
            }
        };

        public static List<CodeExampleEntity> CodeExamples { get; } = new List<CodeExampleEntity>
        {
            new CodeExampleEntity
            {
                Id = 1,
                Title = "Hello World in C#",
                Description = "A simple Hello World example in C# demonstrating basic console output.",
                Code = @"using System;

namespace HelloWorld
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine(""Hello, World!"");
            Console.ReadLine();
        }
    }
}",
                Language = "C#",
                Framework = ".NET",
                Difficulty = "Beginner",
                Category = "Getting Started",
                AuthorId = 1,
                IsPublic = true,
                ViewCount = 150,
                LikeCount = 12,
                CreatedAt = DateTime.UtcNow.AddDays(-20),
                UpdatedAt = DateTime.UtcNow.AddDays(-20)
            },
            new CodeExampleEntity
            {
                Id = 2,
                Title = "REST API with ASP.NET Core",
                Description = "Basic REST API controller example using ASP.NET Core.",
                Code = @"using Microsoft.AspNetCore.Mvc;

[ApiController]
[Route(""api/[controller]"")]
public class ProductsController : ControllerBase
{
    [HttpGet]
    public async Task<ActionResult<IEnumerable<Product>>> GetProducts()
    {
        var products = new List<Product>
        {
            new Product { Id = 1, Name = ""Laptop"", Price = 999.99m },
            new Product { Id = 2, Name = ""Mouse"", Price = 29.99m }
        };
        
        return Ok(products);
    }
    
    [HttpGet(""{id}"")]
    public async Task<ActionResult<Product>> GetProduct(int id)
    {
        // Implementation here
        return NotFound();
    }
}

public class Product
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public decimal Price { get; set; }
}",
                Language = "C#",
                Framework = "ASP.NET Core",
                Difficulty = "Intermediate",
                Category = "Web API",
                AuthorId = 1,
                IsPublic = true,
                ViewCount = 275,
                LikeCount = 23,
                CreatedAt = DateTime.UtcNow.AddDays(-10),
                UpdatedAt = DateTime.UtcNow.AddDays(-10)
            },
            new CodeExampleEntity
            {
                Id = 3,
                Title = "JavaScript Async/Await",
                Description = "Modern JavaScript asynchronous programming with async/await syntax.",
                Code = @"// Async function example
async function fetchUserData(userId) {
    try {
        const response = await fetch(`/api/users/${userId}`);
        
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        
        const userData = await response.json();
        return userData;
    } catch (error) {
        console.error('Error fetching user data:', error);
        throw error;
    }
}

// Usage example
async function displayUser(userId) {
    try {
        const user = await fetchUserData(userId);
        console.log('User:', user);
    } catch (error) {
        console.log('Failed to load user');
    }
}

displayUser(123);",
                Language = "JavaScript",
                Framework = "Vanilla JS",
                Difficulty = "Intermediate",
                Category = "Async Programming",
                AuthorId = 2,
                IsPublic = true,
                ViewCount = 189,
                LikeCount = 16,
                CreatedAt = DateTime.UtcNow.AddDays(-5),
                UpdatedAt = DateTime.UtcNow.AddDays(-5)
            }
        };

        public static int GetNextUserId() => Users.Max(u => u.Id) + 1;
        public static int GetNextCodeExampleId() => CodeExamples.Max(c => c.Id) + 1;
    }
}
