
Q
Command: %s
53*	vivadotcl2 
route_design2default:defaultZ4-113h px? 
?
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
	xc7k325tl2default:defaultZ17-347h px? 
?
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
	xc7k325tl2default:defaultZ17-349h px? 
p
,Running DRC as a precondition to command %s
22*	vivadotcl2 
route_design2default:defaultZ4-22h px? 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px? 
V
DRC finished with %s
79*	vivadotcl2
0 Errors2default:defaultZ4-198h px? 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px? 
V

Starting %s Task
103*constraints2
Routing2default:defaultZ18-103h px? 
}
BMultithreading enabled for route_design using a maximum of %s CPUs17*	routeflow2
22default:defaultZ35-254h px? 
p

Phase %s%s
101*constraints2
1 2default:default2#
Build RT Design2default:defaultZ18-101h px? 
C
.Phase 1 Build RT Design | Checksum: 13920af29
*commonh px? 
?

%s
*constraints2p
\Time (s): cpu = 00:00:40 ; elapsed = 00:00:29 . Memory (MB): peak = 1785.262 ; gain = 78.7852default:defaulth px? 
v

Phase %s%s
101*constraints2
2 2default:default2)
Router Initialization2default:defaultZ18-101h px? 
o

Phase %s%s
101*constraints2
2.1 2default:default2 
Create Timer2default:defaultZ18-101h px? 
B
-Phase 2.1 Create Timer | Checksum: 13920af29
*commonh px? 
?

%s
*constraints2p
\Time (s): cpu = 00:00:41 ; elapsed = 00:00:30 . Memory (MB): peak = 1785.262 ; gain = 78.7852default:defaulth px? 
{

Phase %s%s
101*constraints2
2.2 2default:default2,
Fix Topology Constraints2default:defaultZ18-101h px? 
N
9Phase 2.2 Fix Topology Constraints | Checksum: 13920af29
*commonh px? 
?

%s
*constraints2p
\Time (s): cpu = 00:00:41 ; elapsed = 00:00:30 . Memory (MB): peak = 1785.262 ; gain = 78.7852default:defaulth px? 
t

Phase %s%s
101*constraints2
2.3 2default:default2%
Pre Route Cleanup2default:defaultZ18-101h px? 
G
2Phase 2.3 Pre Route Cleanup | Checksum: 13920af29
*commonh px? 
?

%s
*constraints2p
\Time (s): cpu = 00:00:41 ; elapsed = 00:00:30 . Memory (MB): peak = 1785.262 ; gain = 78.7852default:defaulth px? 
p

Phase %s%s
101*constraints2
2.4 2default:default2!
Update Timing2default:defaultZ18-101h px? 
C
.Phase 2.4 Update Timing | Checksum: 226456cc7
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:00:51 ; elapsed = 00:00:37 . Memory (MB): peak = 1829.574 ; gain = 123.0982default:defaulth px? 
?
Intermediate Timing Summary %s164*route2L
8| WNS=0.851  | TNS=0.000  | WHS=-1.797 | THS=-1615.928|
2default:defaultZ35-416h px? 
I
4Phase 2 Router Initialization | Checksum: 200a26492
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:00:55 ; elapsed = 00:00:39 . Memory (MB): peak = 1838.367 ; gain = 131.8912default:defaulth px? 
p

Phase %s%s
101*constraints2
3 2default:default2#
Initial Routing2default:defaultZ18-101h px? 
C
.Phase 3 Initial Routing | Checksum: 1e9ae888c
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:01:05 ; elapsed = 00:00:44 . Memory (MB): peak = 1862.520 ; gain = 156.0432default:defaulth px? 
s

Phase %s%s
101*constraints2
4 2default:default2&
Rip-up And Reroute2default:defaultZ18-101h px? 
u

Phase %s%s
101*constraints2
4.1 2default:default2&
Global Iteration 02default:defaultZ18-101h px? 
?
Intermediate Timing Summary %s164*route2J
6| WNS=0.851  | TNS=0.000  | WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px? 
H
3Phase 4.1 Global Iteration 0 | Checksum: 1dff6925e
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:02:46 ; elapsed = 00:01:57 . Memory (MB): peak = 1913.793 ; gain = 207.3162default:defaulth px? 
F
1Phase 4 Rip-up And Reroute | Checksum: 1dff6925e
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:02:46 ; elapsed = 00:01:57 . Memory (MB): peak = 1913.793 ; gain = 207.3162default:defaulth px? 
|

Phase %s%s
101*constraints2
5 2default:default2/
Delay and Skew Optimization2default:defaultZ18-101h px? 
p

Phase %s%s
101*constraints2
5.1 2default:default2!
Delay CleanUp2default:defaultZ18-101h px? 
C
.Phase 5.1 Delay CleanUp | Checksum: 1dff6925e
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:02:46 ; elapsed = 00:01:57 . Memory (MB): peak = 1913.793 ; gain = 207.3162default:defaulth px? 
z

Phase %s%s
101*constraints2
5.2 2default:default2+
Clock Skew Optimization2default:defaultZ18-101h px? 
M
8Phase 5.2 Clock Skew Optimization | Checksum: 1dff6925e
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:02:46 ; elapsed = 00:01:57 . Memory (MB): peak = 1913.793 ; gain = 207.3162default:defaulth px? 
O
:Phase 5 Delay and Skew Optimization | Checksum: 1dff6925e
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:02:46 ; elapsed = 00:01:57 . Memory (MB): peak = 1913.793 ; gain = 207.3162default:defaulth px? 
n

Phase %s%s
101*constraints2
6 2default:default2!
Post Hold Fix2default:defaultZ18-101h px? 
p

Phase %s%s
101*constraints2
6.1 2default:default2!
Hold Fix Iter2default:defaultZ18-101h px? 
r

Phase %s%s
101*constraints2
6.1.1 2default:default2!
Update Timing2default:defaultZ18-101h px? 
E
0Phase 6.1.1 Update Timing | Checksum: 1371223f1
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:02:48 ; elapsed = 00:01:58 . Memory (MB): peak = 1913.793 ; gain = 207.3162default:defaulth px? 
?
Intermediate Timing Summary %s164*route2J
6| WNS=0.851  | TNS=0.000  | WHS=-1.764 | THS=-10.495|
2default:defaultZ35-416h px? 
?

Phase %s%s
101*constraints2
6.1.2 2default:default25
!Lut RouteThru Assignment for hold2default:defaultZ18-101h px? 
Y
DPhase 6.1.2 Lut RouteThru Assignment for hold | Checksum: 29821f84d
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:02:49 ; elapsed = 00:01:58 . Memory (MB): peak = 1913.793 ; gain = 207.3162default:defaulth px? 
C
.Phase 6.1 Hold Fix Iter | Checksum: 29821f84d
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:02:49 ; elapsed = 00:01:58 . Memory (MB): peak = 1913.793 ; gain = 207.3162default:defaulth px? 
v

Phase %s%s
101*constraints2
6.2 2default:default2'
Additional Hold Fix2default:defaultZ18-101h px? 
?
Intermediate Timing Summary %s164*route2J
6| WNS=0.851  | TNS=0.000  | WHS=-1.764 | THS=-10.241|
2default:defaultZ35-416h px? 
I
4Phase 6.2 Additional Hold Fix | Checksum: 1d059033b
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:02:52 ; elapsed = 00:02:00 . Memory (MB): peak = 1913.793 ; gain = 207.3162default:defaulth px? 
@
+Phase 6 Post Hold Fix | Checksum: f5445ad5
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:02:55 ; elapsed = 00:02:03 . Memory (MB): peak = 1913.793 ; gain = 207.3162default:defaulth px? 
o

Phase %s%s
101*constraints2
7 2default:default2"
Route finalize2default:defaultZ18-101h px? 
B
-Phase 7 Route finalize | Checksum: 119306387
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:02:56 ; elapsed = 00:02:03 . Memory (MB): peak = 1913.793 ; gain = 207.3162default:defaulth px? 
v

Phase %s%s
101*constraints2
8 2default:default2)
Verifying routed nets2default:defaultZ18-101h px? 
I
4Phase 8 Verifying routed nets | Checksum: 119306387
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:02:56 ; elapsed = 00:02:03 . Memory (MB): peak = 1913.793 ; gain = 207.3162default:defaulth px? 
r

Phase %s%s
101*constraints2
9 2default:default2%
Depositing Routes2default:defaultZ18-101h px? 
D
/Phase 9 Depositing Routes | Checksum: 98f7e6b7
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:02:57 ; elapsed = 00:02:04 . Memory (MB): peak = 1913.793 ; gain = 207.3162default:defaulth px? 
t

Phase %s%s
101*constraints2
10 2default:default2&
Post Router Timing2default:defaultZ18-101h px? 
q

Phase %s%s
101*constraints2
10.1 2default:default2!
Update Timing2default:defaultZ18-101h px? 
C
.Phase 10.1 Update Timing | Checksum: ec699c93
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:02:59 ; elapsed = 00:02:05 . Memory (MB): peak = 1913.793 ; gain = 207.3162default:defaulth px? 
?
Estimated Timing Summary %s
57*route2J
6| WNS=0.851  | TNS=0.000  | WHS=-1.764 | THS=-10.107|
2default:defaultZ35-57h px? 
B
!Router estimated timing not met.
128*routeZ35-328h px? 
F
1Phase 10 Post Router Timing | Checksum: ec699c93
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:02:59 ; elapsed = 00:02:05 . Memory (MB): peak = 1913.793 ; gain = 207.3162default:defaulth px? 
?
qRouter was unable to fix hold violation on %s pins because of tight setup and hold constraints. Such pins are:
%s189*route2
12default:default2i
U	u_ila_0/inst/ila_core_inst/u_ila_regs/reg_7/I_EN_CTL_EQ1.U_CTL/u_wcnt_lcmp_q_i_1/I1
2default:defaultZ35-456h px? 
?
?Router was unable to fix hold violation on %s pins. This could be due to a combination of congestion, blockages and run-time limitations. Such pins are:
%s192*route2
12default:default2h
T	u_ila_0/inst/ila_core_inst/u_ila_regs/reg_7/I_EN_CTL_EQ1.U_CTL/u_scnt_cmp_q_i_2/I1
2default:defaultZ35-459h px? 
@
Router Completed Successfully
2*	routeflowZ35-16h px? 
?

%s
*constraints2q
]Time (s): cpu = 00:02:59 ; elapsed = 00:02:05 . Memory (MB): peak = 1913.793 ; gain = 207.3162default:defaulth px? 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px? 
?
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
1152default:default2
1092default:default2
142default:default2
02default:defaultZ4-41h px? 
^
%s completed successfully
29*	vivadotcl2 
route_design2default:defaultZ4-42h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
route_design: 2default:default2
00:03:042default:default2
00:02:082default:default2
1913.7932default:default2
207.3162default:defaultZ17-268h px? 
D
Writing placer database...
1603*designutilsZ20-1893h px? 
=
Writing XDEF routing.
211*designutilsZ20-211h px? 
J
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px? 
J
#Writing XDEF routing special nets.
210*designutilsZ20-210h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2)
Write XDEF Complete: 2default:default2
00:00:062default:default2
00:00:022default:default2
1913.7932default:default2
0.0002default:defaultZ17-268h px? 
?
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2d
PF:/workspace/xilinx/timingtest/ccd_timing_test.runs/impl_1/TOP_Module_routed.dcp2default:defaultZ17-1381h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2&
write_checkpoint: 2default:default2
00:00:102default:default2
00:00:062default:default2
1913.7932default:default2
0.0002default:defaultZ17-268h px? 
?
%s4*runtcl2?
sExecuting : report_drc -file TOP_Module_drc_routed.rpt -pb TOP_Module_drc_routed.pb -rpx TOP_Module_drc_routed.rpx
2default:defaulth px? 
?
Command: %s
53*	vivadotcl2z
freport_drc -file TOP_Module_drc_routed.rpt -pb TOP_Module_drc_routed.pb -rpx TOP_Module_drc_routed.rpx2default:defaultZ4-113h px? 
>
IP Catalog is up to date.1232*coregenZ19-1839h px? 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px? 
?
#The results of DRC are in file %s.
168*coretcl2?
TF:/workspace/xilinx/timingtest/ccd_timing_test.runs/impl_1/TOP_Module_drc_routed.rptTF:/workspace/xilinx/timingtest/ccd_timing_test.runs/impl_1/TOP_Module_drc_routed.rpt2default:default8Z2-168h px? 
\
%s completed successfully
29*	vivadotcl2

report_drc2default:defaultZ4-42h px? 
?
%s4*runtcl2?
?Executing : report_methodology -file TOP_Module_methodology_drc_routed.rpt -pb TOP_Module_methodology_drc_routed.pb -rpx TOP_Module_methodology_drc_routed.rpx
2default:defaulth px? 
?
Command: %s
53*	vivadotcl2?
?report_methodology -file TOP_Module_methodology_drc_routed.rpt -pb TOP_Module_methodology_drc_routed.pb -rpx TOP_Module_methodology_drc_routed.rpx2default:defaultZ4-113h px? 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px? 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px? 
Y
$Running Methodology with %s threads
74*drc2
22default:defaultZ23-133h px? 
?
2The results of Report Methodology are in file %s.
450*coretcl2?
`F:/workspace/xilinx/timingtest/ccd_timing_test.runs/impl_1/TOP_Module_methodology_drc_routed.rpt`F:/workspace/xilinx/timingtest/ccd_timing_test.runs/impl_1/TOP_Module_methodology_drc_routed.rpt2default:default8Z2-1520h px? 
d
%s completed successfully
29*	vivadotcl2&
report_methodology2default:defaultZ4-42h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2(
report_methodology: 2default:default2
00:00:152default:default2
00:00:092default:default2
1913.7932default:default2
0.0002default:defaultZ17-268h px? 
?
%s4*runtcl2?
?Executing : report_power -file TOP_Module_power_routed.rpt -pb TOP_Module_power_summary_routed.pb -rpx TOP_Module_power_routed.rpx
2default:defaulth px? 
?
Command: %s
53*	vivadotcl2?
vreport_power -file TOP_Module_power_routed.rpt -pb TOP_Module_power_summary_routed.pb -rpx TOP_Module_power_routed.rpx2default:defaultZ4-113h px? 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px? 
K
,Running Vector-less Activity Propagation...
51*powerZ33-51h px? 
P
3
Finished Running Vector-less Activity Propagation
1*powerZ33-1h px? 
?
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
1272default:default2
1092default:default2
142default:default2
02default:defaultZ4-41h px? 
^
%s completed successfully
29*	vivadotcl2 
report_power2default:defaultZ4-42h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
report_power: 2default:default2
00:00:152default:default2
00:00:102default:default2
1969.0002default:default2
55.2072default:defaultZ17-268h px? 
?
%s4*runtcl2u
aExecuting : report_route_status -file TOP_Module_route_status.rpt -pb TOP_Module_route_status.pb
2default:defaulth px? 
?
%s4*runtcl2?
?Executing : report_timing_summary -max_paths 10 -file TOP_Module_timing_summary_routed.rpt -rpx TOP_Module_timing_summary_routed.rpx -warn_on_violation 
2default:defaulth px? 
s
UpdateTimingParams:%s.
91*timing2:
& Speed grade: -2L, Delay Type: min_max2default:defaultZ38-91h px? 
|
CMultithreading enabled for timing update using a maximum of %s CPUs155*timing2
22default:defaultZ38-191h px? 
?
rThe design failed to meet the timing requirements. Please see the %s report for details on the timing violations.
188*timing2"
timing summary2default:defaultZ38-282h px? 
?
%s4*runtcl2g
SExecuting : report_incremental_reuse -file TOP_Module_incremental_reuse_routed.rpt
2default:defaulth px? 
x
TNo incremental reuse to report, no incremental placement and routing data was found.278*	vivadotclZ4-545h px? 
?
%s4*runtcl2g
SExecuting : report_clock_utilization -file TOP_Module_clock_utilization_routed.rpt
2default:defaulth px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
report_clock_utilization: 2default:default2
00:00:082default:default2
00:00:092default:default2
1972.0122default:default2
0.0002default:defaultZ17-268h px? 


End Record