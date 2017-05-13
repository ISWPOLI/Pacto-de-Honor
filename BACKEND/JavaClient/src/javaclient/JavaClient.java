package javaclient;

import javax.ws.rs.client.Client;
import javax.ws.rs.client.WebTarget;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

/**
 * Cliente para consumir los servicios REST
 * @author jrubiaob
 */
public class JavaClient {
    
    private WebTarget webTarget;
    private Client client;
    private static final String BASE_URI = "http://localhost:8080/Polifight/webresources/personaje";

    public JavaClient() {
        this.client = javax.ws.rs.client.ClientBuilder.newClient();
        this.webTarget = client.target(BASE_URI).path("getId").queryParam("token", "962C7B2EBEB246ACB132C4BAA90E52E6170417155119");
    }
        
    /**
     * Método que consume el método getId de la entidad Personaje e imprime los id
     * de cada uno de ellos     
     */
    public static void main(String[] args) {
        JavaClient j = new JavaClient();
        try{
            WebTarget resource = j.webTarget;
            String response = resource.request(javax.ws.rs.core.MediaType.APPLICATION_JSON).get(String.class);
            System.err.println(response);
            JSONParser parser = new JSONParser();
            Object obj = parser.parse(response);
            JSONObject jsonObject = (JSONObject) obj;
                        
            // loop array
            JSONArray data = (JSONArray) jsonObject.get("datos");
            for (int i = 0; i < data.size(); i++) {
                JSONParser parser1 = new JSONParser();
                Object obj1 = parser1.parse(String.valueOf(data.get(i)));
                
                JSONObject jsonObject1 = (JSONObject) obj1;
                String id = String.valueOf(jsonObject1.get("idPersonaje"));              
                System.err.println(id);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        
    }
    
}
