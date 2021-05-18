build:
	docker build --tag=dicegroup/netl .

test:
	docker rm netl-test ||true
	docker run \
	-v `pwd`/model_run/toy_data/toytopics.csv:/data/topics.csv \
	--name netl-test dicegroup/netl
	docker cp netl-test:/usr/src/app/model_run/output_unsupervised model_run/
	docker cp netl-test:/usr/src/app/model_run/output_supervised model_run/
	docker rm netl-test
