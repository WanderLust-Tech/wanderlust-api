# CORS Configuration Guide

## Overview
The API now supports flexible CORS configuration to allow specific frontend origins instead of allowing all origins for better security.

## Configuration Methods

### 1. Using appsettings.json (Recommended)
Configure allowed origins in your `appsettings.json` or `appsettings.Production.json`:

```json
{
  "CORS": {
    "AllowedOrigins": [
      "https://localhost:3000",
      "http://localhost:3000",
      "https://localhost:5173",
      "http://localhost:5173",
      "https://your-production-domain.com"
    ]
  }
}
```

### 2. Using Environment Variables
Set the `FRONTEND_URL` environment variable:

```bash
# For development
FRONTEND_URL=http://localhost:3000

# For production
FRONTEND_URL=https://your-production-domain.com
```

### 3. Multiple Origins via Environment (Advanced)
You can also override the entire configuration section via environment variables:

```bash
CORS__AllowedOrigins__0=https://localhost:3000
CORS__AllowedOrigins__1=https://your-production-domain.com
```

## Configuration Priority
The system checks for CORS configuration in this order:

1. **appsettings CORS:AllowedOrigins array** (highest priority)
2. **FRONTEND_URL environment variable** (fallback)
3. **Default development URLs** (localhost:3000, localhost:5173) (last resort)

## Production Setup

### For Azure/Cloud Deployment
Add environment variables in your hosting platform:
- `FRONTEND_URL=https://your-frontend-domain.com`

### For Docker
```dockerfile
ENV FRONTEND_URL=https://your-frontend-domain.com
```

### For IONOS/Traditional Hosting
Update `appsettings.Production.json`:
```json
{
  "CORS": {
    "AllowedOrigins": [
      "https://your-actual-frontend-domain.com"
    ]
  }
}
```

## Security Notes

1. **Never use `AllowAnyOrigin()` in production** - this is a security risk
2. **Always specify exact domains** - avoid wildcards in production
3. **Use HTTPS in production** - HTTP origins should only be used for development
4. **Enable credentials** - The configuration includes `AllowCredentials()` for authentication support

## Testing CORS

### Frontend Setup
Your frontend `VITE_API_URL` should point to your backend:

```env
# Development
VITE_API_URL=http://localhost:5000

# Production
VITE_API_URL=https://your-api-domain.com
```

### Verification
1. Check browser developer tools for CORS errors
2. Verify `Access-Control-Allow-Origin` headers in network tab
3. Ensure preflight OPTIONS requests succeed

## Common Issues

### Issue: CORS Error in Browser
**Solution**: Ensure your frontend domain is in the `AllowedOrigins` list

### Issue: Credentials Not Working
**Solution**: Verify both frontend and backend support credentials:
- Backend: `AllowCredentials()` is enabled ✅
- Frontend: Use `credentials: 'include'` in fetch requests

### Issue: Environment Variables Not Working
**Solution**: 
- Restart the application after setting environment variables
- Check the configuration priority order above
- Verify environment variable naming (case-sensitive)

## Example Frontend Configuration

```typescript
// In your frontend API service
const apiCall = async (endpoint: string, options: RequestInit = {}) => {
  const response = await fetch(`${import.meta.env.VITE_API_URL}${endpoint}`, {
    ...options,
    credentials: 'include', // Important for authentication
    headers: {
      'Content-Type': 'application/json',
      ...options.headers,
    },
  });
  return response;
};
```
