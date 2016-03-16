% This function returns true is the state with coordinates X,Y is already in the list
function Bool=Is_In_List(X,Y,List)
for i=1:size(List,1)
    if ((List(i,1)==X) || (List(i,2)==Y))
        Bool=1;
        return;
    end
end
Bool=0;
