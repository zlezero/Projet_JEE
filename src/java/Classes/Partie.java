package Classes;

import java.util.Random;

/**
 *
 * @author tvathonn
 */
public class Partie {
    
    private int nbrCoups;
    private Sommets sommetCourant;
    
    public Partie() {
        nbrCoups = 0;
        sommetCourant = Sommets.A;
    }
    
    public void Jouer() {
        
        Random r = new Random();
        int lanceDe;
        
        while (sommetCourant != Sommets.C) {
            
            lanceDe = r.nextInt(6);
        
            if (lanceDe % 2 == 0) {
                deplacement(Deplacement.HORIZONTAL);
            }
            else {
                deplacement(Deplacement.VERTICAL);
            }
            
            nbrCoups++;
            
        }
        
    }
    
    private void deplacement(Deplacement deplacement) {
        
        if (deplacement == Deplacement.HORIZONTAL) { //Deplacement horizontal
            
            switch (sommetCourant) {
                case A:
                    sommetCourant = Sommets.B;
                    break;
                case B:
                    sommetCourant = Sommets.A;
                    break;
                case C: 
                    break;
                case D:
                    sommetCourant = Sommets.C;
                    break;
            }
            
        }
        else { //Déplacement vertical
            
            switch (sommetCourant) {
                case A:
                    sommetCourant = Sommets.D;
                    break;
                case B:
                    sommetCourant = Sommets.C;
                    break;
                case C: 
                    break;
                case D:
                    sommetCourant = Sommets.A;
                    break;
            }
            
        }
        
    }
    
    public int getNbrCoups() {
        return nbrCoups;
    }
    
    public Sommets getSommetCourant() {
        return sommetCourant;
    }
    
    public boolean aGagne() {
        return sommetCourant == Sommets.C;
    }
    
    public void setNbrCoups(int nbrCoups) {
        this.nbrCoups = nbrCoups;
    }
    
    public void setSommetCourant(Sommets sommetCourant) {
        this.sommetCourant = sommetCourant;
    }
    
}
