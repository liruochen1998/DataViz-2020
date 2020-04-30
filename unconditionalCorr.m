function [unconditionalTable] = unconditionalCorr(equity, equityName, fx, fxName)
    %UNCONDITIONALCORR Summary of this function goes here
    %   Detailed explanation goes here

    equityNum = size(equity, 2);
    fxNum = size(fx, 2);
    result = zeros(fxNum, equityNum);
    for i=1:equityNum
        for j=1:fxNum
            currCorr = corrcoef( fx(:, j), equity(:, i));
            result(j, i) = currCorr(1, 2);
        end
    end
    unconditionalTable = array2table(result);
    unconditionalTable.Properties.RowNames = fxName;
    unconditionalTable.Properties.VariableNames = equityName;
    unconditionalTable.Maturity =  fxName';
    
end

