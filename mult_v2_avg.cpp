#include <iostream>
#include <string>
#include <fstream>
#include <sstream>
#include <algorithm>
#include <cmath>

// here jobs run from 1..
int main()
{
    int nev = 100;          //or 50 depending on the cent.                                                                                                                                                                                                                                                                                                                                   

    double *dN_ch =new double[nev]();
    double *v2    =new double[nev]();
    int *event    =new int[nev]();
    std::ofstream out("mult_list.dat");

    int miss=0;

    for (int i=0; i<nev; i++)
    {
        event[i]=i+1;
        std::ostringstream fn;
        fn << "job-"<<i+1<<"/hadronic_afterburner_toolkit/results/particle_9999_vndata_eta_-0.5_0.5.dat";
        std::ifstream ini (fn.str());
        if(!ini)
        {
            dN_ch[i] = 0.;
            v2[i]    = 0.;
            miss++;
            std::cerr<<"Can't open file: "<<fn.str()<<std::endl;
            continue;
        }
        std::string line;
        getline(ini,line);   //ignore header
        getline(ini,line);   //order 0
        
        double order, qnr, qnrer, qni, qnier;
        std::istringstream iss(line);
        iss>>order>>qnr>>qnrer>>qni>>qnier;
        dN_ch[i] = qnr;

        getline(ini,line);  //order 1
        getline(ini,line);  //order 2

        
        std::istringstream iss2(line);
        iss2>>order>>qnr>>qnrer>>qni>>qnier;
        v2[i] = std::sqrt( (qnr*qnr)+(qni*qni) );
    }

    double n_mean=0.;
    double v2_mean=0.;
    for(int i=0;i<nev;i++)
    { 
        n_mean  += dN_ch[i];
        v2_mean += v2[i];
    }
    std::cout<<"Average mult: "<< (n_mean/(double)(nev-miss))<<std::endl;
    std::cout<<"Average v2: "<< (v2_mean/(double)(nev-miss))<<std::endl;

    for(int i=0;i<nev;i++)
        out<<event[i]<<"\t"<<dN_ch[i]<<"\t"<<v2[i]<<std::endl;
    out.close();
    delete [] dN_ch;    delete [] v2;   delete [] event;
    return (0);
}
