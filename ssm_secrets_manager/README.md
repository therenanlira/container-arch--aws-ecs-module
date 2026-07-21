# ssm_secrets_manager

Provisiona um segredo no AWS Secrets Manager (secret + uma versão com o valor). Útil para injetar configuração/segredos no `secrets` do módulo [`ecs_service`](../ecs_service).

## Uso

```hcl
module "ssm_secret" {
  source = "git::https://github.com/therenanlira/container-arch--aws-modules.git//ssm_secrets_manager?ref=v1"

  service_name = "app"
  value        = "abc123456"
}
```

O nome do segredo é montado como `/<workspace>/<região>/<service_name>` (ex.: `/dev/us-east-2/app`).

## Inputs

| Nome | Descrição | Tipo | Default |
| --- | --- | --- | --- |
| `service_name` | Nome do segredo (parte final do path) | `string` | — |
| `value` | Valor do segredo | `string` | — |

## Outputs

| Nome | Descrição |
| --- | --- |
| `arn` | ARN do segredo (usado em `valueFrom` do `secrets` do `ecs_service`) |
