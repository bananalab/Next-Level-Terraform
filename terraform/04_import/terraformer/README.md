# Import

1. Download terraformer
```bash
curl -LO https://github.com/GoogleCloudPlatform/terraformer/releases/download/0.8.22/terraformer-aws-linux-amd64
chmod +x terraformer-aws-linux-amd64
```

2. Initailaze terraform versions
```bash
terraform init
```

3. Import resources
```bash
./terraformer-aws-linux-amd64 import aws --resources vpc
```