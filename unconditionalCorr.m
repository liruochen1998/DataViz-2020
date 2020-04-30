function [unconditionalTable] = unconditionalCorr(equity, equityName, fx, fxName)
    %UNCONDITIONALCORR Summary of this function goes here
    % Author: Larry Li
    % TIme: 4/30/2020
    % Input arguments:
    % equity: equity data with time on column, different equity on row
    % equityName: A string array storing all the equity names
    % fx: fx data with time on column, different maturities on row
    % fxName: A string array storing all fx names
    % Output:
    % unconditionalTable: annoted table that are ready to be used by Power
    % BI directly

    equityNum = size(equity, 2); % num of different equites (# of columns)
    fxNum = size(fx, 2); % num of idfferent fx (# of columns)
    result = zeros(fxNum, equityNum); % space for holding the result
    % going through the equities and bonds to calculate the correlations
    % one by one
    for i=1:equityNum
        for j=1:fxNum
            currCorr = corrcoef( fx(:, j), equity(:, i));  %current correlation
            result(j, i) = currCorr(1, 2); %store it
        end
    end
    
    % table making: accomdate for Power BI specific format
    unconditionalTable = array2table(result);
    unconditionalTable.Properties.RowNames = fxName;
    unconditionalTable.Properties.VariableNames = equityName;
    unconditionalTable.Maturity =  fxName';
    
end

