function [corrTable] = conditionalCorr(equity, equityName, fx, fxName, windowSize, date)
    %CONDITIONALCORR Summary of this function goes here
    %   Detailed explanation goes here
    % Author: Larry Li
    % TIme: 4/30/2020
    % Input arguments:
    % equity: equity data with time on column, different equity on row
    % equityName: A string array storing all the equity names
    % fx: fx data with time on column, different maturities on row
    % fxName: A string array storing all fx names
    % windowSize: rolling windowSize (in days)
    % date: datetime column for table making, accomodating for Power BI
    % Output:
    % corrTable: annoted table that are ready to be used by Power
    % BI directly
    
    equityLength = size(equity, 2); %# of equities
    fxLength = size(fx, 2); % # of bonds
    panelLength = size(equity, 1); % the lengh (# of times) for each asset
    corrLength = size(equity, 2) * size(fx, 2); % # of paris that we need to stack. Eg. 5x11=55
    result = zeros(panelLength, corrLength); % temp for holding timexparisOfAssets result
    availLength = panelLength - windowSize; % adjustment for window size
    
    % calculating the correlation by interation
    for i=1:availLength
        for j=1:equityLength
            currEquity = equity(:, j); %select current equity
            for k=1:fxLength
                currFX = fx(:, k); % select current bonds
                cr = corrcoef(currEquity(i:i+windowSize), currFX(i:i+windowSize));
                result(i, 11*(j-1)+k) = cr(1, 2); %filling first column, then second column, etc.
            end
        end
    end
    
    
    % helper to make the pair names. Eg. cnsmr&10yr
    finalName = strings(1, corrLength);
    for i=1:equityLength
        for j=1:fxLength
            finalName(1, 11*(i-1) + j) = equityName(1, i) + "&" + fxName(1, j);
        end
    end
    
    
    % cut the excess data that won't be used because of rolling
    result = result(1:availLength, :);
    % table making for Power BI specific format
    t = table(date(1:availLength, :), result(:, 1), repmat(finalName(1, 1), availLength, 1));
    %t = t(1:3560, :); % arbitrary resizing
    % stack all the data together, for PowerBI required format
    for i=1:corrLength
        curr = table(date(1:availLength, :), result(:, i), repmat(finalName(1, i), availLength, 1));
        %curr = curr(1:3560, :); arbitrary resizing
        t = vertcat(t, curr);
    end
    
    % add another roll, for PowerBI graph making requirement
    tag = "rolling" + windowSize + "Days";
    t.Var4 = repmat(tag, size(t, 1), 1);

    corrTable = t;% return
end

