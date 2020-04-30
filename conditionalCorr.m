function [corrTable] = conditionalCorr(equity, equityName, fx, fxName, windowSize, date)
    %CONDITIONALCORR Summary of this function goes here
    %   Detailed explanation goes here

    
    equityLength = size(equity, 2);
    fxLength = size(fx, 2);
    panelLength = size(equity, 1);
    corrLength = size(equity, 2) * size(fx, 2);
    result = zeros(panelLength, corrLength);

    availLength = panelLength - windowSize;
    for i=1:availLength
        for j=1:equityLength
            currEquity = equity(:, j);
            for k=1:fxLength
                currFX = fx(:, k);
                cr = corrcoef(currEquity(i:i+windowSize), currFX(i:i+windowSize));
                result(i, 11*(j-1)+k) = cr(1, 2);
            end
        end
    end
    
    
    finalName = strings(1, corrLength);
    for i=1:equityLength
        for j=1:fxLength
            finalName(1, 11*(i-1) + j) = equityName(1, i) + "&" + fxName(1, j);
        end
    end
    
    
    result = result(1:availLength, :);
    t = table(date(1:availLength, :), result(:, 1), repmat(finalName(1, 1), availLength, 1));
    %t = t(1:3560, :); % arbitrary resizing
    for i=1:corrLength
        curr = table(date(1:availLength, :), result(:, i), repmat(finalName(1, i), availLength, 1));
        %curr = curr(1:3560, :); arbitrary resizing
        t = vertcat(t, curr);
    end
    tag = "rolling" + windowSize + "Days";
    t.Var4 = repmat(tag, size(t, 1), 1);

    corrTable = t;


end

