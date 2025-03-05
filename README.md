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

1. ## Criar a VPC

  - Acesse a pasta vpc.
  - Execute os comandos do Terraform listados abaixo para criar a rede.

2. ## Obter e Configurar IDs

  - Após a criação da VPC, obtenha os IDs da Subnet e do Security Group.
  - Atualize o arquivo main.tf localizado em modules/ec2, substituindo os valores apropriados.

3. ## Criar a Instância EC2

  - Retorne à raiz do projeto **asap-tech-terraform**.
  - Acesse a pasta ec2.
  - Execute os comandos do Terraform listados abaixo para provisionar a instância.
   
Isso garante que a infraestrutura seja criada na ordem correta, evitando falhas de dependência.

# Inicializar o Terraform:

    terraform init

Isso configurará o backend remoto e baixará os provedores necessários.

Verificar o plano de execução:

    terraform plan

Esse comando mostra as mudanças que serão aplicadas na infraestrutura.

Aplicar as mudanças:

    terraform apply

Confirme a execução digitando yes.






# Continuação para deploy dos arquivos Helm

📖 Documentação: Deploy do Nginx no Kubernetes com Helm e Kind

 Este documento descreve como configurar e expor um serviço Nginx em um cluster Kubernetes utilizando Helm e Kind. Ele abrange desde a criação do cluster até a verificação dos serviços que foram criados.

# Criar um Cluster Kubernetes com Kind

## Crie um cluster Kind chamado helm-cluster:

Configurar o cluster com um Ingress Controller, crie um arquivo kind-config.yaml e rode:
        
    kind create cluster --name helm-cluster --config kind-config.yaml

Verifique se o cluster está rodando:

    kubectl cluster-info --context kind-helm-cluster

# Criar o Helm Chart do Nginx
Agora, vamos criar e organizar os arquivos corretamente:

  Clone o projeto com os arquivos e deixe na seguinte estrutura.

  asap-tech-test-terraform/helm-files/
 * Chart.yaml
 * values.yaml
 * **templates**/
   * deployment.yaml
   * service.yaml



Implantar o Helm Chart no Cluster

Agora, dentro da pasta **helm-files**, rode:

    helm install my-nginx . --namespace default

Se quiser usar outra imagem (ex: Redis), pode sobrescrever os valores com --set:

    helm install my-redis . --set image.repository=redis --set image.tag=latest


Verifique se os pods estão rodando:

    kubectl get pods
 
 Verifique os serviços:
 
    kubectl get svc
