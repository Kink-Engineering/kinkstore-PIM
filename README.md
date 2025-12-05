# Kinkstore PIM

A Product Information Management (PIM) system for managing ~1,000 products with media management, product data editing, and Shopify synchronization.

## Overview

This system migrates from Google Drive-based media storage to a database-driven solution with cloud storage (Storj), providing:

- **Product Management**: Import and sync products/variants from Shopify
- **Media Management**: Upload, organize, and edit images and videos
- **Publishing Workflow**: Assign media to products and publish to Shopify
- **Video Encoding**: Integration with external video encoding service
- **Role-Based Access**: Admin, photographer, writer, and viewer roles

## Tech Stack

| Component | Technology |
|-----------|------------|
| Frontend | React (Vercel) |
| Backend | Node.js API (Vercel) |
| Database | PostgreSQL (Supabase) |
| File Storage | Storj (S3-compatible) |
| Authentication | Auth0 + Google OAuth |
| E-commerce | Shopify Admin GraphQL API |
| Video Encoding | External GraphQL API |

## Documentation

- **[Implementation Plan](PLAN.md)** - Full 8-week implementation plan with phases, tasks, and technical details
- **[Database Schema](database-schema.md)** - Entity relationship diagrams, table definitions, and query patterns

## Key Concepts

### SKU Architecture
- **Product `sku_label`**: Internal identifier (e.g., `RSV-V-PRODUCTXYZ`)
- **Variant `sku`**: Actual Shopify SKU (e.g., `RSV-V-PRODUCTXYZ-S`, `RSV-V-PRODUCTXYZ-M`)
- For single-variant products, these must match

### Media Buckets vs Publishing
- **Media Buckets**: Organizational storage containers (one per product)
- **Publishing**: Defined by `product_media_associations` table - images must be explicitly assigned to be published

### Storage
- **Storj**: Raw files, edited files, project files (PSDs)
- **External CDN**: Encoded videos (URL stored in database)

## Project Status

**Status**: Planning Complete - Ready for Implementation

See [PLAN.md](PLAN.md) for the detailed implementation roadmap.

