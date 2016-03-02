# BIT: Biologically Inspired Tracker
Bolun Cai, Xiangmin Xu, Xiaofen Xing, Kui Jia, Jie Miao and Dacheng Tao
###Introduction
Visual tracking is challenging due to image variations caused by various factors, such as object deformation, scale change, illumination change, and occlusion. Given the superior tracking performance of human visual system (HVS), an ideal design of biologically inspired model is expected to improve computer visual tracking. This is, however, a difficult task due to the incomplete understanding of neurons’ working mechanism in the HVS. This paper aims to address this challenge based on the analysis of visual cognitive mechanism of the ventral stream in the visual cortex, which simulates shallow neurons (S1 units and C1 units) to extract low-level biologically inspired features for the target appearance and imitates an advanced learning mechanism (S2 units and C2 units) to combine generative and discriminative models for target location. In addition, fast Gabor approximation and fast Fourier transform are adopted for real-time learning and detection in this framework. Extensive experiments on large-scale benchmark data sets show that the proposed biologically inspired tracker performs favorably against the state-of-the-art methods in terms of efficiency, accuracy, and robustness.

If you use these codes in your research, please cite:

	@article{cai2016bit,
		author = {Bolun Cai, Xiangmin Xu, Xiaofen Xing, Kui Jia, Jie Miao and Dacheng Tao},
		title={BIT: Biologically Inspired Tracker},
		journal={IEEE Transactions on Image Processing},
		year={2016},
		volume={25},
		number={3},
		pages={1327-1339},
	}
	
### Results
#### 1. Precisions plots on the TB2013: [Result](https://github.com/caibolun/BIT/blob/master/BIT_TRE_result.zip?raw=true "BIT_TRE_result.zip")
![Precisions plots](https://raw.githubusercontent.com/caibolun/BIT/master/TB50.jpg)
#### 2. Survival curves on the ALOV300++:
  ![Survival curves](https://raw.githubusercontent.com/caibolun/BIT/master/ALOV.jpg)
#### 3. Video Demo                      
[![BIT](http://img.youtube.com/vi/ODJ9bFog6Kk/0.jpg)](http://www.youtube.com/watch?v=ODJ9bFog6Kk)
