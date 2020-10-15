build:
	docker build --tag=dicegroup/netl .

test:
	docker run \
	-v `pwd`/model_run/pre_trained_models:/usr/src/app/model_run/pre_trained_models \
	-v `pwd`/model_run/support_files:/usr/src/app/model_run/support_files \
	-v `pwd`/model_run/toy_data/toytopics.csv:/data/topics.csv \
	--name netl dicegroup/netl
	docker cp netl:/usr/src/app/model_run/output_unsupervised .
	docker cp netl:/usr/src/app/model_run/output_supervised .
	docker rm netl
