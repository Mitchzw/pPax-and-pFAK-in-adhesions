# pPax-and-pFAK-in-adhesions

This repository contains the relevant code for our publication https://doi.org/10.1101/2020.09.24.311126

After publishing a final manuscript in a print journal, code will be uploaded to the long-term file server of University of Geneva (Yareta). Code on Yareta will be the reference for code used in the publication while code in this repository might be changed and adapted over time. 

Part of the content of this repository is a matlab workflow (folder Multi_image...) developed by Artiom Skripka (twitter @a_skripka). This code allowes to detect intensity maxima of labeled proteins within focal adhesions and additional characterization of them. 

File "Notebook_NN-Analysis" is a file for Jupyter Notebook. It also contains code for an ImageJ macro that can be used to get NN data from image files. The rest of the code deals with files obtained with this macro and makes the code accessible for further analysis and for plotting.

File "Analysis_CrossCorrelation_Kymographs" is written by Nikolaos Athanasopoulos and calculates a cross-correlation from kymographs as shown in Fig. 6 in our publication. Input is a .csv file with x/y coordinates and intensity of the kymograph that can be obtained in ImageJ (select all, Analyze - Tools - Save XY coordinates).

Michael Bachmann, 31/01/2022
