# local-Observability
a step-by-step guide to deploying an Observability Stack using Terraform, LocalStack, and Bash Scripts. The setup includes OpenSearch (ELK/ELS stack alternative), AWS CloudWatch, and S3 for centralised logging.


# Install LocalStack
```bash
pip install localstack awscli-local
```
# Start LocalStack
```bash
localstack start -d
```
Step 2: Configure AWS CLI for LocalStack
```bash
export AWS_ACCESS_KEY_ID="test"
export AWS_SECRET_ACCESS_KEY="test"
export AWS_DEFAULT_REGION="us-east-1"
export AWS_ENDPOINT="http://localhost:4566"

aws configure set aws_access_key_id test
aws configure set aws_secret_access_key test
aws configure set region us-east-1
```

# Install Logstash on Mac
```bash
brew tap elastic/tap
brew install elastic/tap/logstash-full
```

```bash
logstash -f logstash.conf
```

```bash
chmod +x generate_logs.sh
./generate_logs.sh
```