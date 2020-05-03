# Remove as virtualenvs atuais
echo "Removendo virtual envs"
rm -rf ../envia-multa-servico/.venv
rm -rf ../multa-api/.venv
rm -rf ../veiculo-api/.venv

# Cria virtualenvs para envia-multa-servico e instala suas as deps
echo "Criando envia-multa-servico venv"
python3 -m venv ../envia-multa-servico/.venv
python3 -m venv ../envia-multa-servico/.venv2
source ../envia-multa-servico/.venv/bin/activate
pip install -r ../envia-multa-servico/requirements.txt
source ../envia-multa-servico/.venv2/bin/activate
pip install -r ../envia-multa-servico/requirements2.txt
deactivate

# Cria virtualenv para multa-api e instala as deps
echo "Criando multa-api venv"
python3 -m venv ../multa-api/.venv
source ../multa-api/.venv/bin/activate
pip install -r ../multa-api/requirements.txt
deactivate

# Cria virtualenv para veiculo-api e instala as deps
echo "Criando veiculo-api venv"
python3 -m venv ../veiculo-api/.venv
source ../veiculo-api/.venv/bin/activate
pip install -r ../veiculo-api/requirements.txt
deactivate

# Migrando banco de dados
echo "Removendo banco de dados antigos"
rm -rf ../multa-api/db.sqlite3
rm -rf ../veiculo-api/db.sqlite3

echo "Criando banco de dados de multa-api"
source ../multa-api/.venv/bin/activate
python ../multa-api/multa-api/manage.py migrate
deactivate

echo "Criando banco de dados de veiculo-api"
source ../veiculo-api/.venv/bin/activate
python ../veiculo-api/veiculo-api/manage.py migrate
deactivate

echo "Baixando imagem do goaws"
# goaws nos fornece a infraestutura para rodar o SNS e SQS localmente
docker pull pafortin/goaws


