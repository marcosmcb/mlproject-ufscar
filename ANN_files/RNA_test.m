function [ output ] = ...
    RNA_test(test_data, pesos_InputInterm, pesos_IntermInterm, pesos_IntermOutput)

    a_input = horzcat(1, test_data);
    a_interm = horzcat(1, 1 ./ (1 + exp(-a_input * pesos_InputInterm)));
    output = 1 ./ (1 + exp(-a_interm * pesos_IntermOutput));
end

