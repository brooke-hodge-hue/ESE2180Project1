function currentData = computeCurrents(resistanceData,x)
%Get the number of links in the resistor network 
numLinks = size(resistanceData,1);

%Create a matrix to store the current data 
currentData = zeros(numLinks,3);

%loop through the links 
for k = 1:numLinks 
    %Get the two connected nodes and resistances
    node1 = resistanceData(k,1);
    node2 = resistanceData(k,2);
    R = resistanceData(k,3);

    %Get the voltages at each node 
    V1 = x(node1);
    V2 = x(node2);
   
    %Calculate the current through the link 
    current = (V1-V2)/R;

    %Store the two nodes and the currents 
    currentData(k,1)=node1;
    currentData(k,2)=node2;
    currentData(k,3)=current;
end 

end 