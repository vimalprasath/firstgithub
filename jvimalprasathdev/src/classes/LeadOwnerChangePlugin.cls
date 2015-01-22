global without sharing  class LeadOwnerChangePlugin implements Process.Plugin { 
global Process.PluginResult invoke(Process.PluginRequest request) { 
        
        Id leadId = (ID) request.inputParameters.get('leadId');
        Id ownerId = (ID) request.inputParameters.get('ownerId');
        Lead leadInfo = [Select id, ownerId from lead where Id = :leadId];
        if(!(leadInfo.ownerId).equals(ownerId)|| !(leadInfo.ownerId).equals('')){
            leadInfo.ownerId = ownerId;
            system.debug('********post****'+leadinfo.ownerId);
        }
        try{
        update leadInfo;
        }Catch (exception e){}
        
        Map<String,Object> result = new Map<String,Object>(); 
        return new Process.PluginResult(result);  
    } 

    // Returns the describe information for the interface
global Process.PluginDescribeResult describe() { 
        Process.PluginDescribeResult result = new Process.PluginDescribeResult(); 
        result.Name = 'LeadOwnerChangePlugin';
        result.Tag = 'Call Capture';
        result.inputParameters = new 
        List<Process.PluginDescribeResult.InputParameter>{ 
           new Process.PluginDescribeResult.InputParameter('leadId', 
           Process.PluginDescribeResult.ParameterType.ID, true),
           new Process.PluginDescribeResult.InputParameter('ownerId', 
           Process.PluginDescribeResult.ParameterType.ID, true)
        }; 
        result.outputParameters = new 
           List<Process.PluginDescribeResult.OutputParameter>{};
        return result; //result
    }
}