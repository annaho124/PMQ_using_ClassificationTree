# 1. PMQ - Process Monitoring for Quality:
Process Monitoring for Quality (PMQ) is a new quality assurance philosophy which is a blend of Process Monitoring (PM) and Quality Control (QC) and based on the usage of 
Big Data and Big Model to improve the manufacturing process and quality. PMQ is developed by a group of researchers in Global R&D faculty of General Motors. 
The objective of this philosophy is using the sensors data from manufacturing process to predict the product quality. 
# 2. Steps of problem-solving strategy in PMQ:
!['Evolution of the problem-solving strategy in the quality movement'](https://user-images.githubusercontent.com/65806329/119638497-ebe88280-be40-11eb-8169-e96afb866423.png)


Big data has impacted engineering and manufacturing and has resulted in better and more efficient manufacturing operations, improved quality, and more personalized products. A less apparent effect is that big data have changed problem solving: the problems we choose to solve, the strategy we seek, and the tools we employ (Abell et al, 2017). So with more and more data generated, we can not only use the descriptive analytics as answering 'what is happening in our process?- but also use diagnostic analytics to answer why the defects happened, why the machine broke down - and predictive analytics - will the defects happen and when will it happen? Abell et al. (2017) introduced the new phisology in quality control fields, focused on predictive analytics with the data gathered from the process sensors to predict the products quality classes. This phisology applied on the process of ultrasonic welding of battery tabs (UWBT) which is the components of electric cars in General Motors factory.

!['Iconic representation of the PMQ philosophy'](https://user-images.githubusercontent.com/65806329/119639164-8b0d7a00-be41-11eb-9574-23b1ec731974.png)

There are 4 steps in PMQ process:
* Acsensorize: The intent of acsensorization is to ensure that all the physical aspects of the process are captured so that information from the data could provide an insight into the process. In addition to the choice of sensors, the characteristics of the sensors, such as their range of sensitivity, and their placement and installation require
engineering expertise.
* Discover: The task in discover step is identifying the important features related to the outcome to build models. Data collected from the process sensors also need to convert into the useful inputs. 
* Learn: With features created from the prior step, this step combine model creation and rule creation.
* Predict: The model created will be implemented on classified the future data gather from the process.

# 3. Case study using Classification Tree:
## 3.1 Data:
Data using in this case study is downloaded from: https://www.kaggle.com/podsyp/production-quality

## 3.2 Problem:
With the data from the roasting machine in data_X file and quality data in data_Y file, we need to build the predictive model predict the future data.

## 3.3 Preprocessing data:
These steps using SQL
* From the original data_X file, every observation is the result from every minutes, since the data_Y generated data from every hours. We need to group the data_X in hour by using the mean values of 60 minutes.
* Then we join the updated data_X and data_Y using datetime columns. The dataset finally split into training and testing data with the ratio 6:4 respectively.
* Since we will use the classification model to predict Y values into "good" or "suspect" classes, we need to convert Y values into category variables. In Statistical Process Control (SPC), we using the Control Chart with 6-Sigma to identify the 'Good Quality Range'. The values in 6-Sigma will be labeled as 'Good' and the other values labeled 'Suspect'
## 3.4 Building model:
These steps using Google Colab, you can see this file in this reposity:
* The principles to build the Classification model is recursive partitioning. the outcome variable by Y and the input (predictor) variables by X1, X2, X3, …, Xp. In
classification, the outcome variable will be a categorical variable. Recursive partitioning divides up the p-dimensional space of the X predictor variables into nonoverlapping multidimensional rectangles. This division is accomplished recursively (i.e., operating on the results of prior divisions).
* The accuracy of classification tree is evaluated by confusion matrix.
