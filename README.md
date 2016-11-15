# NETL-Automatic-Topic-Labelling-

Pre-Trained Models
==========================
* [Doc2Vec trained model (6.8GB)](https://ibm.ent.box.com/s/j0efvic365d13pcn43px73pmt1mpwmxz)
* [Word2vec trained model(ngrams) (2.3GB)](https://ibm.ent.box.com/s/15xfv95o0xjfu2zdweggyrkufk1d2j7q)

Additional support files
==========================
* Pre computed PageRank 
* Wordvec Phrase list
* Filtered Document titles

Some Python Library Requirements
============
* Gensim
* Numpy
* Pandas

Additional Libraries and Tools Needed
==========================
To run NETL there are some other libraries invloved to process wikipedia dump, tokenisation and for supervised learning.
* [WIkiExtractor Tool] (https://github.com/attardi/wikiextractor)
* [Stanford Parser] (http://nlp.stanford.edu/software/stanford-parser-full-2014-08-27.zip)
* [SVM Rank]  (http://download.joachims.org/svm_rank/current/svm_rank_linux64.tar.gz)


Running the System
=============================
Directly running the pre-trained system and get the labels.(Training the System not need for this step)
* Download the pre-trained models, SVM rank binary files (namely svm_rank_classify and svm_rank_learn) and PageRank from the URLs provided above.
* Place doc2vec and word2vec models in model_run/pre_trained_models.
* Place the pagerank file,svm_rank_classify and svm_rank_learn in model_run/support_files.
* Make sure your data topic file is in csv format  and placed in model_run/data. Update the path of your topic file in get_labels.py (in parameter data). Currently it points to toy_data/toytopics.csv. 
* Run get_labels.py by "python get_labels.py -cg -us -s" (will give you candidate labels in a file with supervised and unsupervised labels printed on console")

Train the System.
* Download a Wiki xml dump and place it in training/dump
* Download the Standford Parser, WikiExtractor.py, word2vec phrase file from the Urls provided above.
* Place Stanford pasrser and WikiExtractor.py in training/support_packages.
* Place word2vec phrasefile in training/additional_files.
* Run main_train.py "python main_train.py -e -td -ng -dv -wv". 
* Word2vec and Doc2vec models will be saved in training/trained_models and additional tokenisd documents and other documents will be placed in training/processed_documents.

* If you need your own word2vec phrase file can run word2vec_phrase.py but will need to alter the procedure a bit. Run "python main_train.py -e -td" and then run word2vec_phrases.py. After that again run "python main_train.py -ng -dv -wv" 


Input Format
=============================
The input format if just need to run the model
* Topic file: One line per topic (displaying top-N words) in .csv format. Path to this file be updated in get_labels.py
* Candidate labels file: Note: This is only needed if you already have candidate labels and wnat to just get supervised and   unsupervised ranking of those labels. one line per topic displaying candidate labels. Should corespond to the topic file in ordering.
Examples given in model_run/toy_data/temptopics.csv 

The input format for training a new model.
*XML Dump from Wikipedia. Place it in training/dump.

Directory Structure and Files
=============================
There are 2 main directories. First is is model_run. It creates files which are used to directly run and give us candidate labels, unsupervised and supervised labels. Download the models, put the path in and directly run it wthout the training step.

* model_run/get_labels.py: this script has all the parameters for running the model. All path to doc2vec, word2vec and svm is given here.
* model_run/cand_generation.py: This file generates candidate labels for the topic and output in a file
* model_run/unsupervised_labels.py: This will give you the best labels for your topic in totaly unsupervised way using letter trigram.
* model_run/supervised_labels.py: Run this to get labels in supervised labels. It will use SVM Ranker classify to give you supervised labels for your topic.
* model_run/toy_data/toytopics.csv: Just contains a sampple topic file to get the format for your input
* model_run/toy_data/cand_label_output: A sample output of candidate labels generated.
* model_run/pre_trained_model. Directory to place trained doc2vec and word2vec models.
* model_run/data : Place your topic dat file here.
* model_run/support_files/svm_model: Trained svm model on our dataset.
* model_run/support_files/doc2vec_indices: These are indices coreesponding to doc2vec tags from our pre trained doc2vec model for filtered document titles.
* model_run/support_files/word2vec_indices.These are indices coresponding to wrod2vec tag from our word2vec model from our filtered word2vec phrase list.

 The second directory is training.The training directory contains script and code for training the embedding models. The files in training are:
* training/main_train.py: This is the script where all the parameters for training the system our specified. This is the file which is used to run the system.
* training/extract.py: This contain a call to WikiExtractor.py and converts wikipedia xml dump into documents.
* training/tokenisation.py: This uses stanford parser tokeniser to tokenise extracted XML dump.
* training/doc2vectrain.py: Calls the gensim based Doc2Vec model and train the Doc2Vec model for tokenised documents.
* training/create_ngrams: It uses filtered Wikipedia titles file.(either downloaded from URL above of Word2vec Phrase list or generated using word2vec_phrases.py) and creates n-grams(n<=4) in documents. These phrases have an underscore between them. 
* training/word2vectrain.py: Calls the gensim based Word2Vec model and train the word2vec mode on documents modifed by create_ngrams.py.
* training/processed_documents: Output from extract.py, tokenisation.py and create-ngrams. py are saved here in separate directories.
* training/trained_models. The final trained doc2ve and word2vec models are place here.
* training/support_packages- Stanford Parser and WikiExtractor.py should be put here.
* training/additional_files - Download the word2vec phrase list file and is placed here or if you generate this file using word2vec_phrase.py the output is saved over here.

Some additional code files:
* train_svm_model.py. If you want to again train the svm model on a dataset. Update the parameters in this file for your own model. Currently it points to our dataset.
 * pruned_documents.py: It take all the document tags (which are wikipedia titles) generated by the doc2vecmodel and then filters them such that documents which are shorter than 40 words or if tag length (wikipedia title) is more than 4 words. These filtered tags are only considered for getting the potential labels for topics. This file is already generated if you need in Filtered Document titles above or can generate your own using this scrpt.
* word2vec_phrases.py: This also does similar as pruned_dcoments.py but since output of this file is used in generating word2vec file we remove any brackets fromthe wikipedia title and tokenise it using StanFord tokeniser. Again if you ned a pre computed one URL is given above word2vec phrase list. These labels are only considered to get a potential label from word2vec model.
*  get_indices.py: This model takes output of pruned_ocuments.py and word2vec+phrase.py and just gives theindex position of those labels in the respective models. Again for ease of just running the model they are already computed and placed in model_run/support_files.

Datasets
==========================
* A Topic file given which has 228 topics with its 10 terms from four domains namely blogs,books,news and pubmed.
* Annotated files: For each topic 19 labels were annotated.

Publication
==========================