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
        int lanceDe = r.nextInt(6);
        
        
        
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
