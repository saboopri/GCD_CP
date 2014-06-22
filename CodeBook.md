CodeBook
========
Link to Original Data : http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The TidyData set includes 720 observations from 21 variables. 

Below is the list of variables with information about them. 


|   | Variable                     | Range/Levels                                                             | NA |  
|---|------------------------------|--------------------------------------------------------------------------|----|
| 1 | Subject                      | 1 to 30                                                                  | no |   
| 2 | Activity                     | Walking, Walking upstairs, Walking Downstairs, Sitting, Standing, Laying | no |  
| 3 | Coordinates                  | X, Y, Z, MAG                                                             | no |  
| 4 | time_body_acc_mean           | -1 to 1                                                                  | no |  
| 5 | time_gravity_acc_mean        | -1 to 1                                                                  | no |  
| 6 | time_body_acc_jerk_mean      | -1 to 1                                                                  | no |   
| 7 | time_body_gyro_mean          | -1 to 1                                                                  | no |  
| 8 | time_body_gyro_jerk_mean     | -1 to 1                                                                  | no |  
| 9 | frequency_body_acc_mean      | -1 to 1                                                                  | no |  
|10 | frequency_body_gyro_mean     | -1 to 1                                                                  | no |   
|11 | frequency_body_acc_jerk_mean | -1 to 1                                                                  | no |  
|12 | time_body_acc_std            | -1 to 1                                                                  | no |  
|13 | time_gravity_acc_std         | -1 to 1                                                                  | no |   
|14 | time_body_acc_jerk_std       | -1 to 1                                                                  | no |   
|15 | time_body_gyro_std           | -1 to 1                                                                  | no |  
|16 | time_body_gyro_jerk_std      | -1 to 1                                                                  | no |  
|17 | frequency_body_acc_std       | -1 to 1                                                                  | no |   
|18 | frequency_body_gyro_std      | -1 to 1                                                                  | no |   
|19 | frequency_body_acc_jerk_std  | -1 to 1                                                                  | no |   
|20 | frequency_body_gyro_jerk_mean| -1 to 1                                                                  | yes|   
|21 | frequency_body_gyro_jerk_std | -1 to 1                                                                  | yes|


The data has been scaled by dividing by the range and so the units are cancelled. Therefore the data has no units.
