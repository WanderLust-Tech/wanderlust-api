# GitHub Actions Secrets Setup for API Deployment

## Required Secrets

To enable automatic API deployment via GitHub Actions, you need to configure the following secrets in your GitHub repository:

### Navigation to Secrets
1. Go to your GitHub repository
2. Click **Settings** tab
3. In the left sidebar, click **Secrets and variables** → **Actions**
4. Click **New repository secret**

## API Staging Environment Secrets

Configure these secrets for staging deployment:

```
API_STAGING_FTP_HOST
API_STAGING_FTP_USER
API_STAGING_FTP_PASSWORD
API_STAGING_FTP_PORT (optional, defaults to 21)
API_STAGING_FTP_SECURE (optional, set to "true" for FTPS)
API_STAGING_FTP_REMOTE_PATH (e.g., "/api-staging")
```

## API Production Environment Secrets

Configure these secrets for production deployment:

```
API_PROD_FTP_HOST
API_PROD_FTP_USER
API_PROD_FTP_PASSWORD
API_PROD_FTP_PORT (optional, defaults to 21)
API_PROD_FTP_SECURE (optional, set to "true" for FTPS)
API_PROD_FTP_REMOTE_PATH (e.g., "/api")
```

## Example Secret Values

### For a typical hosting provider:

**API_PROD_FTP_HOST**
```
ftp.yourhosting.com
```

**API_PROD_FTP_USER**
```
your-ftp-username
```

**API_PROD_FTP_PASSWORD**
```
your-secure-ftp-password
```

**API_PROD_FTP_REMOTE_PATH**
```
/httpdocs/api
```

**API_PROD_FTP_SECURE** (optional)
```
true
```

## Environment Setup

The workflow uses GitHub Environment protection rules. You may want to set up environments:

1. Go to **Settings** → **Environments**
2. Create environments: `api-staging` and `api-production`
3. Configure protection rules (e.g., require approval for production)

## Workflow Trigger

The API deployment workflow triggers on:

- **Push to main/master** with changes to .cs, .csproj, or .json files
- **Manual trigger** via GitHub Actions UI
- **Pull requests** (build only, no deployment)

## Testing the Setup

1. **Check the workflow file** exists at `.github/workflows/deploy-api.yml`
2. **Add all required secrets** to your repository
3. **Make a test change** to any .cs file or project configuration
4. **Push to main branch** and check the Actions tab

## Troubleshooting

### Common Issues

**Workflow doesn't trigger:**
- Ensure changes are to .cs, .csproj, or .json files
- Check that you're pushing to `main` or `master` branch

**FTP connection fails:**
- Verify FTP credentials in secrets
- Check if FTPS is required (`API_PROD_FTP_SECURE=true`)
- Confirm the FTP server allows connections from GitHub's IP ranges

**Build fails:**
- Check .NET version compatibility (currently using .NET 8)
- Verify project file path is correct
- Check for missing dependencies

**Deployment fails:**
- Verify remote path exists and is writable
- Check FTP user permissions
- Ensure sufficient disk space on server

## Manual Deployment

You can also trigger deployment manually:

1. Go to **Actions** tab
2. Select **Deploy API** workflow
3. Click **Run workflow**
4. Choose the branch and click **Run workflow**

This is useful for:
- Emergency deployments
- Testing the deployment process
- Deploying without code changes
