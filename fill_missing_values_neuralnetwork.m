function [ out ] = fill_missing_values_neuralnetwork( current_design_matrix, current_observation_matrix, indata, varargin )
            method = varargin(1);
            
            if strcmp(method, 'cascadeforward')
                [~,neuronsPerLayer,hiddenLayers,maxEpochs,goal,max_fail,performanceFnc,learningFnc] = args_with_default_values(varargin,[],30,1,100,1E-5,50,'mse','trainlm');
                hLayers = repmat(neuronsPerLayer,1,hiddenLayers);                
                net = cascadeforwardnet(hLayers,learningFnc);
                net.trainParam.epochs = maxEpochs;
                net.trainParam.goal = goal;
                net.performFcn = performanceFnc;
                net.trainParam.max_fail = max_fail;
                %net=train(net, current_design_matrix', current_observation_matrix', 'useGPU', 'yes');
                net=train(net, current_design_matrix', current_observation_matrix');
                out = sim(net, indata')';                
            end
end

