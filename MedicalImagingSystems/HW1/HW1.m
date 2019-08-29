%Script to generate figures shown in HW 1
%Author: Jake Bergquist
%Aug 27 2019


%Problem 1

%For a 256 x 256 image the centroid is at (128 128)
%Each line of the triangle makes a 60 degree angle at each vertex. If we
%draw a line from each vertex to the center this line bisects the angles
%made by the side, making 3 new triagles (all with equal measurements) and
%whose verticies that are not at the centroid are 30 degrees and the angles
%at the centroid are 120 degrees. Given that the base of each of these
%triangles is 160 pixels (based ont he alrger 160 pixel equalatteral
%triangle) we can determine the length of the line between the centroid and
%any vertex of the larger triangle to be (160/2)/cos(30). We can also
%determine how far the centroid is from each of the lines that make up the
%larger triangle by a simmilar formulation, that being (160/2)*Tan(30).
%Thus the bottom left vertex should be at a positiont hat is translated
%fromt he center by (-(160/2), -(160/2)*Tan(30)) and the bottom right
%vertex similarly should be translated from the center by ((160/2), -(160/2)*Tan(30)).
%The final vertex is directly over the center and translated up
%by (0 , (160/2)/cos(30))
%This defines the verticies. To define the lines that connect them we must
%define the equations of the three lines that make up the triangle.
%for the bottom line the equation is 