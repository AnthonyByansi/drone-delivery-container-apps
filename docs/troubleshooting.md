# Troubleshooting Guide

## Common Issues

### 1. Container Apps Not Deploying

**Problem:** Container apps fail to deploy or remain in a pending state.

**Solution:**
- Verify your Azure Container Apps Environment is healthy
- Check container image path and credentials
- Review application logs in Azure Portal
- Ensure resource quotas aren't exceeded

### 2. Network Connectivity Issues

**Problem:** Services cannot communicate with each other.

**Solution:**
- Verify network configuration in Azure Container Apps
- Check if required ports are exposed
- Ensure DNS resolution is working correctly
- Validate service-to-service communication settings

### 3. Application Scaling Problems

**Problem:** Apps not scaling as expected.

**Solution:**
- Review scaling rules configuration
- Check resource limits and requests
- Verify metrics are being collected correctly
- Ensure autoscaling parameters are properly set

## Getting Support

If you continue experiencing issues:
1. Check Azure Service Health
2. Review Azure Container Apps documentation
3. Open a support ticket with Azure
4. Check GitHub issues for known problems

## Logging and Monitoring

To diagnose issues:
- Enable application insights
- Review container logs
- Monitor resource usage
- Check event logs
