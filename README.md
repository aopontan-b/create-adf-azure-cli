[クイックスタート: Azure CLI を使用して Azure データ ファクトリを作成する](https://learn.microsoft.com/ja-jp/azure/data-factory/quickstart-create-data-factory-azure-cli) 見ながら実際に作成してみる

## セットアップ
[Azure Cloud Shell](https://learn.microsoft.com/ja-jp/azure/cloud-shell/overview) 上でazure cli を実行する。
1. この[サイト](https://learn.microsoft.com/ja-jp/azure/cloud-shell/quickstart?tabs=azurecli)を参考に`Cloud Shellの起動`から`サブスクリプションの Azure Cloud Shell への登録`まで進める

2. Cloud Shell上で次のコマンドを実行し、ソースコードを取得
    ```
    git clone https://github.com/aopontan-b/create-adf-azure-cli.git
    cd create-adf-azure-cli
    ```

3. <>部分を書き換えて、次のコマンドを実行して環境変数を設定する
   ```
   export RESOUCE_GROUP_NAME=<作成するリソースグループの名前>
   export STORAGE_ACCOUNT_NAME=<作成するストレージアカウントの名前>
   export FACTORY_NAME=<作成するデータファクトリーの名前>
   ```

4. 次のコマンドを実行して リソース グループ, ストレージ アカウントとコンテナー, データファクトリーを構築し、パイプラインの実行をする
   ```
   ./datafactory.sh
   ```

5. 次のように出力されたらパイプラインの実行が成功している
   ```
   {
      "annotations": [],
      "debugRunId": null,
      ...
      "status": "Succeeded"
   }
   ```

6. リソースのクリーンアップ
   ```
   az group delete --name ${RESOUCE_GROUP_NAME}
   ```

## 参考記事
- [クイックスタート: Azure CLI を使用して Azure データ ファクトリを作成する](https://learn.microsoft.com/ja-jp/azure/data-factory/quickstart-create-data-factory-azure-cli)
- [Azure Cloud Shell の概要](https://learn.microsoft.com/ja-jp/azure/cloud-shell/overview)
- [Azure Cloud Shell のクイックスタート](https://learn.microsoft.com/ja-jp/azure/cloud-shell/quickstart?tabs=azurecli)