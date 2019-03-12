package Classes;

/**
 *
 * @author tvathonn
 */

public class Joueur {
    
    private Partie[] listeParties;
    private int idJoueur;
    
    public Joueur(int idJoueur) {
        this.idJoueur = idJoueur;
        listeParties = new Partie[10];
    }
    
    public Partie getPartieCourante() {
        return listeParties[getNbrParties()];
    }
    
    public int getNbrParties() {
        
        int nbrParties = 0;
        
        for (int i = 0; i != listeParties.length; i++) {
            if (listeParties[i].aGagne()) {
                nbrParties++;
            }
        }
        
        return nbrParties;      
    }
    
}
