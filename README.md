# asap-tech-test-terraform

 # Utilizando Terraform para provicionar a infraestrutura

Pré-requisitos

Antes de começar, certifique-se de ter:

- Uma conta na AWS

- terraform instalado em sua máquina

- awscli configurado com as credenciais corretas


# Criando o Bucket S3 para o State Remoto

O Terraform precisa armazenar o estado da infraestrutura para gerenciar os recursos corretamente. Para isso, utilizamos um bucket no Amazon S3.

Criar um bucket S3:

    aws s3api create-bucket --bucket meu-terraform-state --region us-east-1

Habilitar versionamento para manter o histórico do state:

    aws s3api put-bucket-versioning --bucket meu-terraform-state --versioning-configuration Status=Enabled


# Inicializando o Terraform para deploy dos recursos

Inicializar o Terraform:

    terraform init

Isso configurará o backend remoto e baixará os provedores necessários.

Verificar o plano de execução:

    terraform plan

Esse comando mostra as mudanças que serão aplicadas na infraestrutura.

Aplicar as mudanças:

    terraform apply

Confirme a execução digitando yes.
