# AI for Free - Narrow AI for Perfumes

ยินดีต้อนรับสู่ **AI for Free**! นี่คือ AI แบบ Narrow AI ที่เชี่ยวชาญเรื่องน้ำหอม สามารถเป็นทั้ง Perfumer Designer, ผู้ใช้, และ R&amp;D ให้คุณได้

## สถาปัตยกรรมโปรเจกต์
- **Backend**: Go + Gin Web Framework
- **Database**: PostgreSQL (Aurora)
- **Infrastructure**: Terraform (AWS)

## โครงสร้างไดเรกทอรี
```
ai_perfumer/
├── backend/               # Go backend service
│   ├── cmd/api/          # Main application entrypoint
│   ├── internal/
│   │   ├── handlers/     # HTTP handlers
│   │   ├── repository/   # Database access layer
│   │   └── models/       # Data models
│   └── go.mod
├── migrations/           # SQL database migrations
├── terraform/            # Terraform infrastructure config
├── app.py                # Original Python CLI
└── README.md
```

## API Endpoints
- `GET /api/v1/health` - Health check
- `GET /api/v1/ingredients` - Get all perfume ingredients
- `GET /api/v1/fragrance-families` - Get all fragrance families
- `GET /api/v1/design-tips` - Get perfume design tips
- `POST /api/v1/perfumes` - Create new perfume

## วิธีใช้ Backend (Go)
1. ติดตั้ง dependencies: `cd backend && go mod tidy`
2. ตั้งค่า PostgreSQL และรัน migrations
3. รันเซิร์ฟเวอร์: `go run ./cmd/api`

## Infrastructure as Code (Terraform)
- ใช้ Terraform เพื่อสร้าง Aurora PostgreSQL และ ECR Repository บน AWS
- ตั้งค่าตัวแปรใน `variables.tf` แล้วรัน `terraform init && terraform apply`

## ความสามารถเดิม (Python CLI)
- ให้คำแนะนำเกี่ยวกับกลิ่นหอม
- อธิบายองค์ประกอบของน้ำหอม
- ช่วยออกแบบกลิ่นหอมใหม่
- ตอบคำถามเกี่ยวกับอุตสาหกรรมน้ำหอม

