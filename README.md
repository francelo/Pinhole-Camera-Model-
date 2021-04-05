# Pinhole-Camera-Model-

This project is a simple implementation of the pinhole camera model in Matlab 2020b with the purpose of studying the single camera geometry, in particular the projection from Euclidean space in 3D to the image space in 2D. It is possible to execute the experiment both in a Matlab script and in Simulink.

The file are organized as follows:

- **sistemi_di_riferimento.m**, which is just a script to explain the reference systems that are *world frame* and *camera frame*;
- **camera.m**, which is a script that simulates a projection in the image plane for a point and for a rectangle e creates the relative plots;
- **proj.m**, which contains the function that executes the projection in the image plain;
- **rot.m**, which contains the function that executes the rototraslation from world frame to camera frame;
- **take_photo**, which is a function that returns the projection in another plot 2D (like a photograph);
- **init.m**, is the file in which the variable for the Simulink simulation are initialized;
- **camera_model.slx**, is the simulink model of the pinhole camera, which was also saved in Matlab 2019b (camera_model_2019b.slx);
- **plot_simulink.m**, which is the script for show the results of the Simulink simulation.

