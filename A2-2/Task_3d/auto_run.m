clear all; close all;

run run_task_3d.m
run init_Sfun_Kal.m
sim('BlockD3d.slx')
run plot_3_general.m