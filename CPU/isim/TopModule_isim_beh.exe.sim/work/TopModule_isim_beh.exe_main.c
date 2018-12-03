/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

#include "xsi.h"

struct XSI_INFO xsi_info;

char *IEEE_P_3499444699;
char *IEEE_P_3620187407;
char *STD_STANDARD;
char *IEEE_P_2592010699;


int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    ieee_p_2592010699_init();
    ieee_p_3499444699_init();
    ieee_p_3620187407_init();
    work_a_1991350011_3212880686_init();
    work_a_2717587577_3212880686_init();
    work_a_2424006887_3212880686_init();
    work_a_3464203653_3212880686_init();
    work_a_1208337864_3212880686_init();
    work_a_1011819884_3212880686_init();
    work_a_1272051612_3212880686_init();
    work_a_2250428819_3212880686_init();
    work_a_0483523329_3212880686_init();
    work_a_2109574807_3212880686_init();
    work_a_1478196689_3212880686_init();
    work_a_0674848091_3212880686_init();
    work_a_2267067595_3212880686_init();
    work_a_3199043598_3212880686_init();
    work_a_0370229503_3212880686_init();
    work_a_3117476931_3212880686_init();
    work_a_0290066562_2965261873_init();
    work_a_1991058128_0029521372_init();
    work_a_2849414221_3212880686_init();
    work_a_1266920509_1341405869_init();
    work_a_1797280568_2260688294_init();
    work_a_1504297269_3212880686_init();


    xsi_register_tops("work_a_1504297269_3212880686");

    IEEE_P_3499444699 = xsi_get_engine_memory("ieee_p_3499444699");
    IEEE_P_3620187407 = xsi_get_engine_memory("ieee_p_3620187407");
    STD_STANDARD = xsi_get_engine_memory("std_standard");
    IEEE_P_2592010699 = xsi_get_engine_memory("ieee_p_2592010699");
    xsi_register_ieee_std_logic_1164(IEEE_P_2592010699);

    return xsi_run_simulation(argc, argv);

}
