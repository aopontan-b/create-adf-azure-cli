# echo ${RESOUCE_GROUP_NAME}
# リソース グループを作成
az group create --name ${RESOUCE_GROUP_NAME} --location eastus

# ストレージ アカウントを作成
az storage account create --resource-group ${RESOUCE_GROUP_NAME} \
    --name ${STORAGE_ACCOUNT_NAME} --location eastus

# コンテナーを作成
az storage container create --resource-group ${RESOUCE_GROUP_NAME} --name adftutorial \
    --account-name ${STORAGE_ACCOUNT_NAME} --auth-mode key

# テキストファイルを作成
echo -n "This is text." > emp.txt

# Azure Storage コンテナーにテキストファイルをアップロード
az storage blob upload --account-name ${STORAGE_ACCOUNT_NAME} --name input/emp.txt \
    --container-name adftutorial --file emp.txt --auth-mode key

# Azure データ ファクトリを作成
az datafactory create --resource-group ${RESOUCE_GROUP_NAME} \
    --factory-name ${FACTORY_NAME}

# 作成したデータ ファクトリを確認
az datafactory show --resource-group ${RESOUCE_GROUP_NAME} \
    --factory-name ${FACTORY_NAME}

# ストレージ アカウントの接続文字列を取得
VAR=`az storage account show-connection-string --resource-group ${RESOUCE_GROUP_NAME} \
    --name ${STORAGE_ACCOUNT_NAME} --key primary | jq '.connectionString'`

# リンクサービスを作成
az datafactory linked-service create \
    --factory-name ${FACTORY_NAME} \
    --properties "{\"type\":\"AzureBlobStorage\",\"typeProperties\":{\"connectionString\":$VAR}}" \
    --linked-service-name AzureStorageLinkedService \
    --resource-group ${RESOUCE_GROUP_NAME}

# 入力データセットを作成
az datafactory dataset create --resource-group ${RESOUCE_GROUP_NAME} \
    --dataset-name InputDataset --factory-name ${FACTORY_NAME} \
    --properties @InputDataset.json

# 出力データセットを作成
az datafactory dataset create --resource-group ${RESOUCE_GROUP_NAME} \
    --dataset-name OutputDataset --factory-name ${FACTORY_NAME} \
    --properties @OutputDataset.json

# パイプラインを作成
az datafactory pipeline create --resource-group ${RESOUCE_GROUP_NAME} \
    --factory-name ${FACTORY_NAME} --name Adfv2QuickStartPipeline \
    --pipeline @Adfv2QuickStartPipeline.json

# パイプラインを実行
RUN_ID=`az datafactory pipeline create-run --resource-group ${RESOUCE_GROUP_NAME} \
    --name Adfv2QuickStartPipeline --factory-name ${FACTORY_NAME} | jq -r '.runId'`

# パイプラインが正常に実行されたことを確認
az datafactory pipeline-run show --resource-group ${RESOUCE_GROUP_NAME} \
    --factory-name ${FACTORY_NAME} --run-id ${RUN_ID}
