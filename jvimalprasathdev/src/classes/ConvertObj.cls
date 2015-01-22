/**
 * Calls Object Converter to convert from button 
 *
 * Author: Sunil Nautiyal
 **/

global class ConvertObj {

	Webservice static String convert(ID leadId, String objects) {
		String targetId=null;
		try{
			
			if(ObjectConverter.isRunning) return 'Object Converter is already Running.';
			
			ObjectConverter oc = ObjectConverter.getInstance();
			for(String str : objects.split(',')){
				if(!oc.getConverter(str, leadId))
					return 'Error: ' + oc.errorMessage + '. Please contact your system administrator for more information.';
			}
			targetId = oc.targetId;
		}catch(Exception e){
			System.assert(false, e.getMessage());
		}
		return '' + targetId;
	}
}