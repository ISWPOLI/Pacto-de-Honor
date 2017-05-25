/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mundo;

/**
 *
 * @author nimartinezma
 */
public class FactorPsicotecnico {
    private static  String name;
    private static int id;
    private static int points;
    private static int count;
    
    /**
    * Conatructor de un factor
    * 
     * @param name
     * @param id
     * @param points
    */
    public FactorPsicotecnico(String name,int id,int points ){
        this.id=id;
        this.name=name;
        this.points=points;
        this.count=0;
    }
     /**
    * 
    * @return El nombre del factor
    */
   public  String getName(){
        return this.name;
    }
    /**
    * 
    *  Cuenta cuantas ocurrencias tiene un factor
    */
    public  void setCount(){
        this.count+=1;
    }
     /**
    * 
    * @return Los puntos totales de un factor
    */
    public  int getCount(){
        return this.count*this.points;
    }
    public  int getId(){
        return this.id;
    }
}
