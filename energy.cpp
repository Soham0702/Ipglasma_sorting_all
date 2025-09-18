#include <iostream>         
#include <fstream>
#include <sstream>
#include <vector>
#include <string>
#include <iomanip>
#include <cmath>
#include <omp.h>


int main()
{
    int events =2500;
    std::vector <double> energy(events);
    std::ofstream out("2event_data.dat");

#pragma omp parallel for
    for(int i=0; i<events; i++)
    {
//        if( i%100 == 0)
//            std::cout<<"Reading file :  "<<i<<std::endl;
        std::string file = "all_files/epsilon-u-Hydro-TauHydro-" + std::to_string(i) +".dat";
        double count =0.; 
        std::ifstream in1(file);
        if (!in1)
        {
            std::cerr<<"cant open file "<<i<<std::endl;
            exit(1);
        }
        std::string line;
        getline(in1,line);
        while(getline(in1,line))
        {
            double eta,y,x,eps;
//                   utau,ux,uy,ue,
//                   pi00,pi0x,pi0y,pi0e,pixx,pixy,pixe,piyy,piye,piee;
            std::stringstream iss(line);
                iss >> eta >> y >>x >> eps;
//                   >> utau >> ux >> uy >> ue
//                   >> pi00 >> pi0x >> pi0y >> pi0e >> pixx >> pixy >> pixe >> piyy >> piye >> piee;
            count += eps;
        }
        energy[i]= count;
//        if( i%100 == 0)
//            std::cout<<"Done reading!!"<<std::endl;
        

    }
    out<<std::fixed << std::setprecision(10);
    for(int i=0;i<events;i++)
        out<<i<<"\t"<<energy[i]<<std::endl;
    std::cout<<"All done."<<std::endl;
return 0;
}

