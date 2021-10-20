
%Lea Gaille, Assignment 4.1 Introduction to research skills

%The goal of this code is to plot the different links of a city with the
% congestions of each link showed with a grey scale. In this case the data
% is about the city of Barcelona.

%initializaton
close all
clear all
clc

%loading data
load('flow.csv')
%flow measurments (veh) at each time (in sec)
load('links.csv')
%give the informations about every link. In the ordrer the different
%coloumns are: Link ID, Length, Number of lanes, Stating node ID,
%Ending node ID, region.
load('nodes.csv')
%desccribe the typology of the network, giving the x and the y
%coordinate of the node (ID of the node in the first coulumn)
load('occupancy.csv')
%occupancy measurments (%)of each link (ID in the first row) depending
%on time


%Informations of every node
x_coord = nodes(:,2);
y_coord = nodes(:,3);
names = nodes(:,1);

%% Step 1
% Definition of the origin and destination
time_step=abs(occupancy(1,1)-occupancy(2,1));

%Empty vectors which will link the position of the start and end node of each link
start_node = zeros(length(links(:,1)),1);
end_node = zeros(length(links(:,1)),1);

%Fill the two empty vectors with the position of the node i
for i = 1:length(links(:,1))
    start_node(i) = find(nodes(:,1)==links(i,4));
    end_node(i) = find(nodes(:,1)==links(i,5));

end
ID_nodes = nodes(:,1);

%isolate the x and y coordinates of each node from the global data nodes
x_coordinate_node = nodes(:,2);
y_coordinate_node = nodes(:,3);


% iterations on the different times with the diagraph function
for i=1:3
    %time at which we want to analyse the system
    t_g=[60,90,120];

    % t_G is used to find the data at the time that we are interested in
    % picking the row of the data corresponding to t_g
    t_G=t_g*60/time_step +1;

    %function to plot a directed graph, which has directional edges,
    %connecting the nodes. It allows to represent the different links
    G_2=digraph(start_node',end_node',occupancy(t_G(i),2:end));


    %plot the figure with the links and the congestion at the given time
    figure()
    a=plot(G_2,'XData',x_coordinate_node,'YData',y_coordinate_node);
    colormap(flipud(gray));
    a.EdgeCData=G_2.Edges.Weight;
    a.NodeColor = [0 0 0];  % node color (black)
    a.MarkerSize = 1;       % node size
    a.LineWidth = 1.3;
    colorbar;

    title("Level of congestion at t = "+ t_g(i)+ "min")

    xlabel("x coordinates")
    ylabel("y coordinates")
end

