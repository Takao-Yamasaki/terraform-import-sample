# terraform-import-sample
- terraform v1.5.0から使用できるようになったimportブロックを試した
## terraform v1.5.0のインストール
- 現在のバージョン確認
```
$ terraform -v
Terraform v1.4.6
on darwin_amd64
+ provider registry.terraform.io/hashicorp/aws v5.38.0
```
- インストール
```
$ tfenv install 1.5.0
$ tfenv use 1.5.0
```
- インストール後のバージョン確認
```
$ terraform -v

Terraform v1.5.0
on darwin_amd64
+ provider registry.terraform.io/hashicorp/aws v5.38.0
```
## インポート結果をファイルに出力する
- NOTE: apply後は、この記述不要になる
```
import {
  // インスタンスIDを指定
  id = "i-0e61014ea453ae3c1"
  // リソースを指定
  to = aws_instance.sample
}
```
- インポートする
```
teraform init
```
- `-generate-config-out=generated.tf`で出力先のファイルを指定
- `ipv6_address_count`と`ipv6_address`が自動で定義され、conflictを起こすが、どちらかコメントアウトする
```
$ terraform plan -generate-config-out=generated.tf
aws_instance.sample: Preparing import... [id=i-0e61014ea453ae3c1]
aws_instance.sample: Refreshing state... [id=i-0e61014ea453ae3c1]

Planning failed. Terraform encountered an error while generating this plan.

╷
│ Warning: Config generation is experimental
│
│ Generating configuration during import is currently experimental, and the
│ generated configuration format may change in future versions.
╵
╷
│ Error: Conflicting configuration arguments
│
│   with aws_instance.sample,
│   on generated.tf line 14:
│   (source code not available)
│
│ "ipv6_address_count": conflicts with ipv6_addresses
╵
╷
│ Error: Conflicting configuration arguments
│
│   with aws_instance.sample,
│   on generated.tf line 15:
│   (source code not available)
│
│ "ipv6_addresses": conflicts with ipv6_address_count
╵
```
- 上記修正後、再度planを実行
```
terraform plan
```
- 適用する
```
terraform apply
```
- stateファイルが生成
```
$ ls
README.md		main.tf
generated.tf		terraform.tfstate
```
## 参考
https://dev.classmethod.jp/articles/terraform-v1-5-0-import-and-check-sample/
