#include <iostream>                                                                                                                                                                                                                                                                                              
#include <fstream>
#include <vector>
#include <string>
#include <sstream>
#include <iomanip>
#include <algorithm>

int main(int argc, char *argv[])
{
    if (argc < 2) {
        std::cerr << "Usage: " << argv[0] << " <input-file>\n";
        return 1;
    }   

    std::ifstream in(argv[1]);
    std::ofstream out("details");

    int nev =5000;


    std::vector <int> iev(nev);
    std::vector <double> en(nev);

    std::string line;
    int k=0;
    while (std::getline(in,line))
    {   
        std::stringstream iss(line);
        iss >>iev[k] >> en[k];
        k++;
    }   

    auto sz = (iev.size() == en.size() &&  iev.size() == nev) ? nev : 0;

    if(sz ==0 )
    {   
        std::cerr<<"Something wrong here !! "<<std::endl;
        exit(1);
    }   


    for(int i=0;i<nev-1;i++)
        for(int j =i+1;j<nev;j++)
            if(en[j]>en[i])
            {
                std::swap( en[j],en[i]);
                std::swap(iev[j],iev[i]);
            }
    

    out<<std::fixed;
    for(int i=0;i<sz;i++)
        out<< iev[i]<<"\t"<< std::setprecision(10)<<en[i]<<std::endl;


    return 0;
}
