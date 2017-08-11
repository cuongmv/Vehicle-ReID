function Method()   
    [ listTrain ] = createListData( 'Train_Demo.lst' );
    [ listTest ] = createListData( 'Test_Demo.lst' );
    mAP = doVehicleReID(listTrain, listTest);    
end

